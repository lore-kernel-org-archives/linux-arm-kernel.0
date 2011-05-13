From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 May 2011 22:15:12 +0100
Subject: [PATCH] ARM: twd: Adjust localtimer frequency withcpufreqnotifiers
In-Reply-To: <BANLkTikY9VBXuT78k3GFkeG+q=ppMsz3iQ@mail.gmail.com>
References: <4D714C17.7080102@gmail.com>
	<AANLkTims4e7o0sPxVnN0D1mNWDH7uC9q=pBQrBoad2os@mail.gmail.com>
	<eea425c066cc69c30f118fb102fff43e@mail.gmail.com>
	<AANLkTi=KcmqmghVxhwGvv79heRU3C+TC-v2VnWSWt7bU@mail.gmail.com>
	<7e9fafa016bfe536ccc373fc2cc7ba61@mail.gmail.com>
	<AANLkTinRNG4nTjh15a2tuJt_iDboHUtomxemSjY+6DcD@mail.gmail.com>
	<AANLkTikkcYw66MiJO9Bpm+De=XD2-1MFxm-CUPp6sMqL@mail.gmail.com>
	<BANLkTi=-T6P0KrsQ8+Ot_inq1JabY62LvA@mail.gmail.com>
	<alpine.LFD.2.02.1105131138460.2831@ionos>
	<BANLkTikY9VBXuT78k3GFkeG+q=ppMsz3iQ@mail.gmail.com>
Message-ID: <20110513211512.GA30539@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2011 at 12:59:20PM +0200, Linus Walleij wrote:
> This patch is interesting because it uses calc_mult_shift() and the current
> localtimer driver for TWD (arch/arm/kernel/smp_twd.c) still uses hardcoded
> mult+shift.

I don't think there's any reason it uses a hard coded shift, just
that's what was the norm when the code was originally written.  It
(and many other clock event code) probably could do with an update.
