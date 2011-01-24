From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 10:28:49 +0000
Subject: [PATCH 02/14] ARM: bitops: switch set/clear/change bitops to
	use ldrex/strex
In-Reply-To: <AANLkTinnQLsa4mOV+SLYxeRrwZdc8N36SW9pK6ne+6TQ@mail.gmail.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peue4-0003SN-Gk@rmk-PC.arm.linux.org.uk>
	<20110123001636.GA20841@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101222323190.8580@xanadu.home>
	<20110123093526.GA26120@n2100.arm.linux.org.uk>
	<AANLkTi=tpnNXm8w9-VFi72nYvXRQV5-jE7Qn9NNk1wLW@mail.gmail.com>
	<AANLkTinnQLsa4mOV+SLYxeRrwZdc8N36SW9pK6ne+6TQ@mail.gmail.com>
Message-ID: <20110124102849.GA18459@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 02:27:24PM +0530, Poddar, Sourav wrote:
> On Mon, Jan 24, 2011 at 2:08 PM, Poddar, Sourav <sourav.poddar@ti.com> wrote:
> > On Sun, Jan 23, 2011 at 3:05 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> >> On Sat, Jan 22, 2011 at 11:44:59PM -0500, Nicolas Pitre wrote:
> >>> At least another person did post results:
> >>>
> >>> http://mid.gmane.org/20110117094602.GA2622 at pulham.picochip.com
> >>> http://mid.gmane.org/20110117110308.GC2622 at pulham.picochip.com
> >>
> >> Slightly different patch - there were three revisions. ?I can't attach
> >> a tested-by given to a different patch to this one.
> >>
> >>> > That means omap2plus_defconfig .38 mainline kernels
> >>> > (including -stable) will remain potentially dangerous when run on
> >>> > SMP capable hardware.
> >>>
> >>> I must admit that this series looks a bit large for stable IMHO. ?I
> >>> think that the fix for stable should limit itself only to prevent SMP
> >>> from being selected if anything else than CPU_32v6K is selected.
> >>
> >> The first three are the bare minimum required for -stable.
> >>
> >
> 
>  Boot tested the 14 patch series ?with CONFIG_SWP_EMULATE enabled, on
>  the following boards :
> 
> 
>   1. Omap2420 SDP
> 
>   2. Omap2430 SDP
> 
>   3. Omap3430 SDP
> 
>   4. Omap4 Blaze
> 
>   Tested-by: Sourav Poddar <sourav.poddar@ti.com>

Thanks.  It's also important to ascertain which filesystems were tested -
could you let me know please?
