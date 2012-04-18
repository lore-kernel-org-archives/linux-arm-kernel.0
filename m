From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Apr 2012 08:15:28 +0000
Subject: [PATCH v2 8/8] ARM: LPC32xx: Device tree support
In-Reply-To: <20120418060230.GC17506@avionic-0098.adnet.avionic-design.de>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de>
 <1334682507-15055-9-git-send-email-stigge@antcom.de>
 <20120418060230.GC17506@avionic-0098.adnet.avionic-design.de>
Message-ID: <201204180815.29234.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 April 2012, Thierry Reding wrote:
> >  arch/arm/mach-lpc32xx/phy3250.c                       |  146 +++++--------
> 
> While at it, this should probably be renamed board-dt.c or something similar
> since it is no longer phy3250 specific.

I believe there are still a few phy3250 specific bits left in there, using auxdata,
right? In that case, I think it's fine to leave the file name for now, but I
think everyhting that is not phy3250 specific should just get moved into common.c
since we don't want to support any other board files for lpc32xx any more.

	Arnd
