From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 May 2013 15:19:08 +0200
Subject: [PATCH 1/5] ARM: socfpga: dts: Add ethernet bindings for SOCFPGA
In-Reply-To: <1368571955-6652-1-git-send-email-dinguyen@altera.com>
References: <1368571955-6652-1-git-send-email-dinguyen@altera.com>
Message-ID: <201305151519.08598.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 May 2013, dinguyen at altera.com wrote:
>                 };
>  
> +               ethernet at ff700000 {
> +                       phy-mode = "gmii";
> +               };
> +
> +               ethernet at ff702000 {
> +                       status = "disabled";
> +               };

By convention, please mark the controllers as "disabled" in the main .dtsi file
and only enable them in the board specific files when used, rather than the
other way round.

	Arnd
