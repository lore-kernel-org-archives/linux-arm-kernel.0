From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Jan 2012 13:33:11 +0000
Subject: [PATCH] ARM: kexec: EOI active and mask all interrupts in	kexec
 crash path
In-Reply-To: <20120118154809.GL29346@mudshark.cambridge.arm.com>
References: <1326898885-28105-1-git-send-email-will.deacon@arm.com>
 <20120118150724.GH1068@n2100.arm.linux.org.uk>
 <20120118153120.GK29346@mudshark.cambridge.arm.com>
 <20120118154044.GJ1068@n2100.arm.linux.org.uk>
 <20120118154809.GL29346@mudshark.cambridge.arm.com>
Message-ID: <20120119133311.GE1701@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 03:48:09PM +0000, Will Deacon wrote:
> On Wed, Jan 18, 2012 at 03:40:44PM +0000, Russell King - ARM Linux wrote:
> > 
> > Is there no way to re-initialize the gic after an interrupt has begun
> > to be processed, but not EOI'd ?
> 
> Unfortunately, I'm not aware of anything like this (I was hoping for some
> reset functionality). I'll double check that I didn't miss anything, but it
> seems that you can't reset the GIC state machine without manually putting it
> all back.

Ok, I re-read the docs and also spoke to some of the hardware guys and it
seems that you can only kill of all the active interrupts from GICv2 (i.e.
Cortex-A15 onwards). So I reckon the best way for the time being is to do
this on the crash path.

Will
