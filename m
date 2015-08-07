From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Fri, 7 Aug 2015 18:50:18 +0800
Subject: [PATCH v3 0/5] Add SMP bringup support for mt65xx socs
In-Reply-To: <20150805223115.GD7557@n2100.arm.linux.org.uk>
References: <1436851111-2369-1-git-send-email-yingjoe.chen@mediatek.com>
 <4831607.pyCH8elj8i@ubix> <20150805223115.GD7557@n2100.arm.linux.org.uk>
Message-ID: <1438944618.14580.5.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-08-05 at 23:31 +0100, Russell King - ARM Linux wrote:
> On Wed, Aug 05, 2015 at 08:44:11PM +0200, Matthias Brugger wrote:
> > On Tuesday, July 14, 2015 01:18:26 PM Yingjoe Chen wrote:
> > > This series add SMP brinup support for MediaTek SoCs. This is based
> > > on v4.2-rc1 and Matthias' next branch (for dts parts).
<...>

> > Applied to v4.2-next/soc-2 and v4.2-next/dts-2 
> 
> I've just NAK'd one of the patches in this set; I don't tend to even see
> mediatek patches normally, as they all head into my junk mailfolder
> because mediatek's mail server setup is truely abysmal (it has broken
> reverse DNS - the DNS positively says that the mail server is not a
> legit owner of the name it claims to be.)

Hi Russell,

Hope you see this.

Thanks for your review. I already pass this information to our IT, hope
they can resolve this soon.


> The problem is that this patch series uses memblock_reserve() way after
> the memory has been transitioned out of memblock's control, so actually
> this has no effect.
> 
> I've seen a number of patches doing this.  I'm not sure what's soo friggin
> hard for people to understand: memblock is about the EARLY stages of
> getting the system up and running.  Once the memory has been handed
> over to the kernel's memory management, memblock MUST NOT BE USED to
> reserve memory.
> 
> There is one place, and one place only in the ARM kernel where
> memblock_reserve() is possible, and that's in the ->reserve machine
> callback.  NOWHERE ELSE is permissible.


It seems we can write memory-reserve node in device tree to do this as
well. Do you prefer us to reserve memblock in reserve callback or using
device tree?

Joe.C
