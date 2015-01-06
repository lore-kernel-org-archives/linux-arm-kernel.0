From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Jan 2015 22:37:55 +0100
Subject: [PATCH] Revert 9fc2105aeaaf56b0cf75296a84702d0f9e64437b to fix
 pyaudio (and probably more)
In-Reply-To: <alpine.LFD.2.11.1501061618340.18844@knanqh.ubzr>
References: <20150104190123.GA20153@amd>
 <alpine.LFD.2.11.1501061519090.18844@knanqh.ubzr>
 <alpine.LFD.2.11.1501061618340.18844@knanqh.ubzr>
Message-ID: <1711034.nUzA8Nch5a@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 January 2015 16:27:05 Nicolas Pitre wrote:
> Tangential question: does anyone still own a working RPC?

I'm pretty sure that Russell still has one. As far as I know there
are quite a lot of RPC in working condition, but most of them are
running RiscOS.

> -lib-$(CONFIG_ARCH_RPC)         += ecard.o io-acorn.o floppydma.o
> +ifeq ($(CONFIG_ARCH_RPC),y)
> +  lib-y                                += ecard.o io-acorn.o floppydma.o
> +  AFLAGS_delay-loop.o          += -march=armv4
> +endif

Looks good to me.

	Arnd
