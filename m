From: jamie@shareable.org (Jamie Lokier)
Date: Fri, 8 Apr 2011 15:35:41 +0100
Subject: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
	check for it on V6
In-Reply-To: <BANLkTinEnn1C8_mKtL6P2YXdPSt1eaUzKA@mail.gmail.com>
References: <20100630131737.GF2822@atomide.com>
	<alpine.LFD.2.00.1006301011520.24097@xanadu.home>
	<20100701092510.GH2822@atomide.com>
	<20100701174051.GA8786@shareable.org>
	<alpine.LFD.2.00.1007012226170.26524@xanadu.home>
	<20100702103744.GJ6632@atomide.com>
	<20100705135526.GF15951@atomide.com>
	<BANLkTim4TTf3KXGYzjcvQ2n-hNbdSQM1eg@mail.gmail.com>
	<alpine.LFD.2.00.1104080911520.28032@xanadu.home>
	<BANLkTinEnn1C8_mKtL6P2YXdPSt1eaUzKA@mail.gmail.com>
Message-ID: <20110408143541.GU26912@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Li Li wrote:
> Nicolas,
> 
> Thanks for the explanation. :)
> 
> I noticed what you mentioned. Actually, Kconfig says TLS EMU might be
> used in some "old" (e.g. pre-armv6) SMP platforms without TLS
> register. In such a case, could we still ensure it's SMP safe by a
> single ldr?

In that case, the hardware TLS 'mcr' is used, which traps and is
emulated by the undefined instruction handler.  It's not fast but
presumably those platforms don't really matter.

See CONFIG_TLS_REG_EMUL in arch/arm/kernel/traps.c, and 'tls_emu'.

'tls_emu' is a constant, so if a kernel built for TLS emulation is run
on something which has the TLS register, it will not work properly.

-- JAmie
