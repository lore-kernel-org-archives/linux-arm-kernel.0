From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Mar 2014 15:21:37 +0000
Subject: [PATCH v2 4/7] dma: of: introduce of_dma_is_coherent() helper
In-Reply-To: <CAL_JsqLQrHwVx0ZbeeasKsTXp_NVMYX1voxhUdjH737tptiAeQ@mail.gmail.com>
References: <1393535872-20915-1-git-send-email-santosh.shilimkar@ti.com>
 <10040083.PbPEQQPCjl@wuerfel>
 <CAL_JsqL6-hoD4F7+adPhsOJXeM5f+wpEuBWg_6AWqj3k2v0NEw@mail.gmail.com>
 <5773663.p5fEFmy536@wuerfel>
 <CAL_JsqLQrHwVx0ZbeeasKsTXp_NVMYX1voxhUdjH737tptiAeQ@mail.gmail.com>
Message-ID: <20140304152137.GL8766@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 02:04:17PM +0000, Rob Herring wrote:
> Adding Will...

Thanks Rob!

> On Fri, Feb 28, 2014 at 9:24 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 28 February 2014 09:14:19 Rob Herring wrote:
> >>
> >> I know Will D was not a fan of this property. Primarily I believe
> >> because you may need to describe more than just a boolean in more
> >> complex bus topologies.
> >
> > I can't think of any example where it's not per-device. Do you
> > think we can end up with a device that has multiple bus master
> > ports, only some of which are coherent, or is there a different
> > concern?
> 
> Perhaps Will can post his slides from the ARM kernel summit or chime
> in here, but I believe it was more that coherency is just one aspect
> of bus master bus topology. The DT models the slave bus hierarchy and
> doesn't model the master side which is becoming more complex and
> needing to be described. In the case of highbank, you have an ACP bus
> with some number of masters on it. They are configurable, but it is
> not the device that is configurable, but really which bus they are
> connected to.

I'm not sure what happened to this slides but, yes, you have the right idea.
It's not only DMA coherency that's directly related to master topology, but
also SMMU configuration and MSI routing will depend on this information.

Using a per-device, boolean property to describe DMA coherency may work for a
simple, statically configured system, but it really just avoids the bigger
issue.

Will
