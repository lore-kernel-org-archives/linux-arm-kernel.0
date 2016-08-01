From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 1 Aug 2016 10:30:24 +0200
Subject: [PATCH 00/13] arm64: Allwinner A64 support based on sunxi-ng
In-Reply-To: <fb559224-561c-3476-1146-96f7aea427f0@arm.com>
References: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
 <fb559224-561c-3476-1146-96f7aea427f0@arm.com>
Message-ID: <20160801103024.cc74c093466d7fdfd91a2587@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 1 Aug 2016 02:43:06 +0100
Andr? Przywara <andre.przywara@arm.com> wrote:

> As this became quite a long read, here a TL;DR:
> - We consider using an SCPI based clock system for the A64, alongside
> allwinner,simple-gates and fixed clocks. We try to avoid any Allwinner
> specific clocks (apart from the simple-gates).
> - ARM Trusted Firmware provides the SCPI implementation - for now, later
> we may move this into a possible arisc firmware.
> - We upstream some basic DT first, possibly omitting any controversial
> clock parts at all.
> 
> Let me know what you think!

Hi Andr?,

This looks interesting.
As I understand, the clock enable/rate setting functions would be in
the arisc. The arisc firmware would be loaded only once in the Soc and
would contain the code for handling this specific SoC.
>From my calculations, this would save about 1Mb of clock descriptions
in the kernel for a universal Allwinner kernel.

But I don't see why you are keeping the simple-gates. The bus gate may
be ungated/gated when the clock is enabled/disabled, and that's what
Allwinner's software does.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
