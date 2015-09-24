From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Thu, 24 Sep 2015 23:44:58 +0800
Subject: [PATCH v3 0/5] Add SMP bringup support for mt65xx socs
In-Reply-To: <1438944618.14580.5.camel@mtksdaap41>
References: <1436851111-2369-1-git-send-email-yingjoe.chen@mediatek.com>
 <4831607.pyCH8elj8i@ubix> <20150805223115.GD7557@n2100.arm.linux.org.uk>
 <1438944618.14580.5.camel@mtksdaap41>
Message-ID: <1443109498.14481.5.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-08-07 at 18:50 +0800, Yingjoe Chen wrote:
> On Wed, 2015-08-05 at 23:31 +0100, Russell King - ARM Linux wrote:
> > The problem is that this patch series uses memblock_reserve() way after
> > the memory has been transitioned out of memblock's control, so actually
> > this has no effect.
> > 
> > I've seen a number of patches doing this.  I'm not sure what's soo friggin
> > hard for people to understand: memblock is about the EARLY stages of
> > getting the system up and running.  Once the memory has been handed
> > over to the kernel's memory management, memblock MUST NOT BE USED to
> > reserve memory.
> > 
> > There is one place, and one place only in the ARM kernel where
> > memblock_reserve() is possible, and that's in the ->reserve machine
> > callback.  NOWHERE ELSE is permissible.
> 
> 
> It seems we can write memory-reserve node in device tree to do this as
> well. Do you prefer us to reserve memblock in reserve callback or using
> device tree?

After consideration, I decide to reserve this memory in device tree. The
memory is already used by trustzone, we should reserved them even when
we don't run SMP. I just sent out a new series, please help to review
them.
Thanks

Joe.C
