From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 May 2010 10:07:48 +0100
Subject: vpack270 and sleep mode
In-Reply-To: <4BFC99CB.2090902@papillon.ru>
References: <1272311167-576-1-git-send-email-marek.vasut@gmail.com>
	<4BFBD01E.8010101@papillon.ru>
	<20100525202447.GD16204@n2100.arm.linux.org.uk>
	<201005252247.57688.marek.vasut@gmail.com>
	<4BFC99CB.2090902@papillon.ru>
Message-ID: <20100526090748.GB25435@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 26, 2010 at 09:47:23AM +0600, 237 Rumjantsev Egor (PROG) wrote:
> platform vpac270-pm.0: EARLY resume
> platform pxa_g64_driver.0: EARLY resume
> platform pxa2xx_dir_keypad.0: EARLY resume
> platform pxa_capture.0: EARLY resume
> platform pxa2xx-ac97: EARLY resume
> platform mfrc531-ssp.0: EARLY resume
> pxa2xx-flash pxa2xx-flash.0: EARLY resume
> Unable to handle kernel paging request at virtual address a03ab26f
> pgd = c6aac000
> [a03ab26f] *pgd=8020040e(bad)
> Internal error: Oops: 803 [#1] PREEMPT
> Modules linked in: ipv6
> CPU: 0    Not tainted  (2.6.28.10-vpac3-splash #90)
> PC is at bad_channel+0x80166/0x91f28
> LR is at platform_pm_resume_noirq+0x48/0x54

This seems to point at pxa2xx-flash.c being the culpret - which brings
up the question why no one else is seeing a problem here.

Does your vpac270 patches touch this file?  If yes, please show those
changes.
