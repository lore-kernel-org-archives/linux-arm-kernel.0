From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Feb 2014 16:24:56 +0100
Subject: [PATCH v2 4/7] dma: of: introduce of_dma_is_coherent() helper
In-Reply-To: <CAL_JsqL6-hoD4F7+adPhsOJXeM5f+wpEuBWg_6AWqj3k2v0NEw@mail.gmail.com>
References: <1393535872-20915-1-git-send-email-santosh.shilimkar@ti.com>
 <10040083.PbPEQQPCjl@wuerfel>
 <CAL_JsqL6-hoD4F7+adPhsOJXeM5f+wpEuBWg_6AWqj3k2v0NEw@mail.gmail.com>
Message-ID: <5773663.p5fEFmy536@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 February 2014 09:14:19 Rob Herring wrote:
> 
> I know Will D was not a fan of this property. Primarily I believe
> because you may need to describe more than just a boolean in more
> complex bus topologies.

I can't think of any example where it's not per-device. Do you
think we can end up with a device that has multiple bus master
ports, only some of which are coherent, or is there a different
concern?

> Effectively, highbank is always coherent. It was only PCI that is
> non-coherent, but I can safely say PCI will never be enabled at this
> point. There are no designs with PCI beyond 1 or 2 validation boards
> (total boards, not designs), and getting PCI to work was quite hacky
> due to only a 1MB window. The other masters are programmable, but only
> the coherent path is used as the non-coherent path actually has some
> issues. I had expected the opposite believing the ACP port would
> actually have issues which is also why I made it configurable.

Ok, I see. I still expect that we will see systems that are only
partially coherent in the future, but it's good to know we don't really
have to deal with backwards-compatibility as long as we can just
hardcode highbank to be always coherent.

I'm especially thankful we don't have to deal with the PCI implementation.

	Arnd
