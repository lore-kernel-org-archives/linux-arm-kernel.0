From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 25 Oct 2010 21:46:05 +0200
Subject: PXA270 Random Hangs at Low Core Freq
In-Reply-To: <A257B8DC-1E93-4888-AA57-AB9A41AF11AA@prograde.net>
References: <471CD45F-4531-4C87-B292-411CE519D0A5@prograde.net>
	<AANLkTim0yMQbMkP7eke3A18TqwuyFz2DvaYoO8bN7o-9@mail.gmail.com>
	<A257B8DC-1E93-4888-AA57-AB9A41AF11AA@prograde.net>
Message-ID: <201010252146.05874.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 October 2010 21:02:42 Michael Cashwell wrote:
> On Oct 22, 2010, at 4:41 AM, Haojian Zhuang wrote:
> > On Fri, Oct 22, 2010 at 8:22 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> >> Dne Po 18. ??jna 2010 19:38:49 Michael Cashwell napsal(a):
> >>> I've been fighting inexplicable hangs on two different PXA270 designs
> >>> running various kernels since early 2.6.28.x. The first board was
> >>> custom (and of dubious integrity) but I'm currently seeing it on
> >>> Gumstix Verdex PROs running 2.6.35.7.
> >> 
> >> Could it be memory-related ? Like, RAM crashes because of refresh speed
> >> or something?
> 
> I wondered about this myself, especially on the custom board and u-boot.
> That's why I hadn't turned to the community until I was on unmodified
> commercial hardware.
> 
> What I'd like to test would be a Gumstix-supplied uboot and current Linux
> with CPUfreq disabled. That would eliminate all the CPUfreq code and its
> plethora of errata from consideration. The problem is that such a setup
> runs at a fixed *high* CPU core frequency. I've never seen that hang.
> 
> The best I've been able to do is two alternate cases (stock high-freq
> u-boot + a current Linux with CPUfreq enabled so that it lowers the speed;
> and my custom u-boot that runs only at low speed + a current Linux with
> CPUfreq disabled so linux just uses what u-boot sets). Both of these hang
> as described.
> 
> Meaningfully rolling back to the Gumstix's vendor-supplied Linux distro is
> more difficult. It's running a 3+ year old 2.6.21 kernel variant that
> lacks support for recent MTD FLASH parts and features like UBIFS. I used
> that version on an OMAP and recall its MMC support was rather sketchy and
> since writing to a uSD card is my test case I'm somewhat doubtful that the
> results from such testing would mean much.
> 
> Lastly, I've run Charles Cazabon's memtester (c. 2006 v 4.0.6) over 99% of
> the free SDRAM for days at a time and have seen no problems at all. If it
> were an outright SDRAM init/timing/refresh issue I'd expect something that
> strenuous to report an error.
> 
> > Suggest to check errata first. Maybe we need some special code sequence.
> 
> I agree that it has the feel of a CPU errata. (What else would hang the
> core so badly that JTAG would disconnect?) So I've re-read the Rev E
> (April 3rd 2009) errata docs from Marvell from start to finish but nothing
> jumps out at me. The problem is not knowing where to focus. Having
> eliminated the CPU-freq code itself (which relies on CPU features with
> many errata) I'm left rather empty handed.
> 
I think I noticed something similar running ZipitZ2 on 312MHz ... yet I was 
unable to figure out the problem as well ...

> My only idea is that some kernel code path (likely interacting with an
> integrated peripheral) is too slow at low core frequencies and is either
> violating the hardware spec outright or is hitting an errata.
> 
> My testing to date (and that I'm on commercial hardware) makes me think
> that others should be seeing the same problem. It won't occur
> out-of-the-box because normally people want highest performance (high core
> CPU frequencies). With the default u-boot and without CPU-freq to lower it
> the hang doesn't happen.
> 
> But perhaps someone has prioritized power savings as I'm trying to do and
> then they should see it.
> 
> -Mike
