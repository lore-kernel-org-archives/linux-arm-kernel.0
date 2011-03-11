From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sat, 12 Mar 2011 00:12:40 +0200
Subject: [PATCH 5/8] ARM: PXA: Z2: Add poweroff function
In-Reply-To: <201103112308.59017.marek.vasut@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
	<201103112353.11261.anarsoul@gmail.com>
	<201103112308.59017.marek.vasut@gmail.com>
Message-ID: <201103120012.41014.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 March 2011 00:08:58 Marek Vasut wrote:
> On Friday 11 March 2011 22:53:11 Vasily Khoruzhick wrote:
> > On Friday 11 March 2011 23:39:03 Marek Vasut wrote:
> > > On Friday 11 March 2011 11:23:40 Vasily Khoruzhick wrote:
> > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > 
> > > This looks bogus to me as you cannot power down the thing. Besides,
> > > where do you resume to from this so-called "powerdown" ? Since the
> > > bootloader will consider it as a legitimate deepsleep resume.
> > 
> > It eats only 0.7mA in deepsleep, but 6.7mA in sleep (PXA2xx has 2 sleep
> > modes), so deepsleep is pretty close to poweroff.
> 
> So the power to the CPU is actually cut? It isn't, right ?

It isn't. But looks like power to memory is cut. But stock bootloader puts it 
in deepsleep to save battery.

> Mine (I use mainline uboot) doesn't.

Can you re-check it?
 
> PSPR is preserved though, right ? So you end up in a really deep crap I
> guess ?

Does u-boot check if PSPR is null?

Regards
Vasily
