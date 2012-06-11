From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jun 2012 14:14:14 +0000
Subject: [PATCH 11/14] ARM: LPC32xx: DTS adjustment for using pl18x
 primecell
In-Reply-To: <1339412537-24485-12-git-send-email-stigge@antcom.de>
References: <1339412537-24485-1-git-send-email-stigge@antcom.de>
 <1339412537-24485-12-git-send-email-stigge@antcom.de>
Message-ID: <201206111414.14264.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 June 2012, Roland Stigge wrote:
>                         sd at 20098000 {
> -                               compatible = "arm,pl180", "arm,primecell";
> +                               compatible = "arm,pl18x", "arm,primecell";
>                                 reg = <0x20098000 0x1000>;
>                                 interrupts = <0x0f 0>, <0x0d 0>;
> +                               status = "disable";
>                         };
>  

The proper way to write this is 'status = "disabled";', with a 'd' at
the end.

	Arnd
