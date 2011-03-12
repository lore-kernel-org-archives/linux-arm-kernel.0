From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 12 Mar 2011 01:05:15 +0100
Subject: [PATCH 5/8] ARM: PXA: Z2: Add poweroff function
In-Reply-To: <201103120030.08986.anarsoul@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
	<201103112316.57914.marek.vasut@gmail.com>
	<201103120030.08986.anarsoul@gmail.com>
Message-ID: <201103120105.15474.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 March 2011 23:30:08 Vasily Khoruzhick wrote:
> On Saturday 12 March 2011 00:16:57 Marek Vasut wrote:
> > On Friday 11 March 2011 23:12:40 Vasily Khoruzhick wrote:
> > > On Saturday 12 March 2011 00:08:58 Marek Vasut wrote:
> > > > On Friday 11 March 2011 22:53:11 Vasily Khoruzhick wrote:
> > > > > On Friday 11 March 2011 23:39:03 Marek Vasut wrote:
> > > > > > On Friday 11 March 2011 11:23:40 Vasily Khoruzhick wrote:
> > > > > > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > > > > 
> > > > > > This looks bogus to me as you cannot power down the thing.
> > > > > > Besides, where do you resume to from this so-called "powerdown"
> > > > > > ? Since the bootloader will consider it as a legitimate
> > > > > > deepsleep resume.
> > > > > 
> > > > > It eats only 0.7mA in deepsleep, but 6.7mA in sleep (PXA2xx has 2
> > > > > sleep modes), so deepsleep is pretty close to poweroff.
> > > > 
> > > > So the power to the CPU is actually cut? It isn't, right ?
> > > 
> > > It isn't. But looks like power to memory is cut. But stock bootloader
> > > puts it in deepsleep to save battery.
> > 
> > Power to memory is cut? How come? You mean rather the refresh is
> > disabled, right ? But anyway, isn't the ram put into self-refresh ?
> 
> Well, it looks like memory content is not preserved, or something wrong
> with bootloader. Anyway, it does not resume after deepsleep for some
> reason, I can't check better, as I have no JTAG. Maybe you can investigate
> this problem?

But resume after deepsleep is unrelated to this patch.

> 
> > > > Mine (I use mainline uboot) doesn't.
> > > 
> > > Can you re-check it?
> > 
> > Check what ? Yes I can ...
> 
> No need, I understand how it works, PSPR is null, so after u-boot loads
> PSPR to pc it performs 'soft reset' (jumps to 0x0, to begin of NOR flash),
> RCSR bits are already cleared, so it just boots kernel.

The note in Table 18 -- Exit from sleep or deep-sleep doesn't clear or set this 
bit -- means PSPR might not be null if you use your deep-sleep-parapowerdown.
> 
> Regards
> Vasily
