From: marex@denx.de (Marek Vasut)
Date: Wed, 5 Mar 2014 14:36:43 +0100
Subject: [PATCH v5 1/8] mtd: spi-nor: copy the SPI NOR commands to a new
 header file
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EAAFCDB@DBDE04.ent.ti.com>
References: <1393238262-8622-1-git-send-email-b32955@freescale.com>
 <5316B9F2.8050301@freescale.com>
 <20980858CB6D3A4BAE95CA194937D5E73EAAFCDB@DBDE04.ent.ti.com>
Message-ID: <201403051436.43830.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 05, 2014 at 08:24:21 AM, Gupta, Pekon wrote:
> Hi Marek, Shijie,
> 
> >From: Huang Shijie [mailto:b32955 at freescale.com]
> >
> >? 2014?03?05? 11:43, Marek Vasut ??:
> >> Why didn't you keep it like that? Was there some reason for that ?
> >
> >http://marc.info/?l=linux-arm-kernel&m=138545182232220&w=4
> >
> >Pekon suggestted  do not touch the m25p80.c.
> >So i just copy these commands to a new header.
> >Anyway, it's really not an important issue for me. :)
> 
> My opinion was that we should not touch m25p80.c because:
> (1)  As m25p80 is already working for various vendors. So unless multiple
>    platforms start using SPI NOR framework, m25p80.c should remain
> untouched. (2) we should not clutter header file with vendor specific
> op-codes as used in m25p80. I was of the opinion that instead of
> hard-coding the vendor specific info as MACROs, such information should be
> taken from DT or platform-data.
> 
> However, this was my thought during initial versions of SPI NOR patches.
> But now if you think that SPI NOR is stable enough that same header info
> can be reused without conflicts, then no problems.
> 
> (Apologies to Huang Shijie for re-work :-) ).

Ah, thanks for explaining, understood. Given that the m25p80.c is reworked later 
in the series anyway, I'm mostly OK with this patch ... even though I'd prefer 
to see no duplication throughout the series ;-)

Best regards,
Marek Vasut
