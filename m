From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 27 Nov 2017 19:48:18 +0100
Subject: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for
 ntp
In-Reply-To: <20171123161040.GS31757@n2100.armlinux.org.uk>
References: <20171013175433.GA22062@obsidianresearch.com>
 <20171123095456.lkc4nkuzsd2q26mm@piout.net>
 <20171123150439.GB18754@mellanox.com>
 <20171123153637.kbqcd2jsek4ybeic@piout.net>
 <20171123161040.GS31757@n2100.armlinux.org.uk>
Message-ID: <20171127184818.GB19577@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/11/2017 at 16:10:40 +0000, Russell King - ARM Linux wrote:
> On Thu, Nov 23, 2017 at 04:36:37PM +0100, Alexandre Belloni wrote:
> > On 23/11/2017 at 08:04:39 -0700, Jason Gunthorpe wrote:
> > > On Thu, Nov 23, 2017 at 10:54:56AM +0100, Alexandre Belloni wrote:
> > > You can't really measure the offset without doing a time set, many
> > > embedded RTCs do not hook up interrupts, etc.
> > 
> > If you don't hook up the interrupt, then all you did is completely
> > pointless because you will never be able to read the correct time from
> > the RTC, you'll have up to a 1s offset.
> 
> That is incorrect.  The kernel provides emulation for the update
> interrupt - it polls the RTC every 1/HZ checking it for a change
> in seconds.
> 
> So, you end up with up to a 1/HZ offset where no interrupt is
> present.
> 

Yes, I forgot about the UIE emulation.

> Please don't base your assumptions on the output of hwclock(8) -
> the output of that which comes after the timezone specifier is
> not documented in the man page, and appears on the face of it to
> be rather random:
> 

I'm not basing myself on hwclock's output because it is indeed quite
random.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
