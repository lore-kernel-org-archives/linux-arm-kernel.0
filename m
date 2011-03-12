From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sat, 12 Mar 2011 10:06:12 +0200
Subject: [PATCH 5/8] ARM: PXA: Z2: Add poweroff function
In-Reply-To: <201103120105.15474.marek.vasut@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
	<201103120030.08986.anarsoul@gmail.com>
	<201103120105.15474.marek.vasut@gmail.com>
Message-ID: <201103121006.12614.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 March 2011 02:05:15 Marek Vasut wrote:
 
> > Well, it looks like memory content is not preserved, or something wrong
> > with bootloader. Anyway, it does not resume after deepsleep for some
> > reason, I can't check better, as I have no JTAG. Maybe you can
> > investigate this problem?
> 
> But resume after deepsleep is unrelated to this patch.

I just want to say that without this patch you can't keep device in low-
powermode, and it can drain full battery in ~week when it's in sleep mode.

> > No need, I understand how it works, PSPR is null, so after u-boot loads
> > PSPR to pc it performs 'soft reset' (jumps to 0x0, to begin of NOR
> > flash), RCSR bits are already cleared, so it just boots kernel.
> 
> The note in Table 18 -- Exit from sleep or deep-sleep doesn't clear or set
> this bit -- means PSPR might not be null if you use your
> deep-sleep-parapowerdown.

Ok, I can clear PSPR before going to deepsleep, would it be enough?

Regards
Vasily
