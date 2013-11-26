From: cjb@laptop.org (Chris Ball)
Date: Tue, 26 Nov 2013 16:37:29 -0500
Subject: [PATCH v2 0/6] mmc: sdhci-esdhc-imx: fix acmd23 unwork and ddr
 not supported on sabresd issues
In-Reply-To: <1383142193-24950-1-git-send-email-b29396@freescale.com> (Dong
 Aisheng's message of "Wed, 30 Oct 2013 22:09:47 +0800")
References: <1383142193-24950-1-git-send-email-b29396@freescale.com>
Message-ID: <87siuig7za.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

On Wed, Oct 30 2013, Dong Aisheng wrote:
> Patch 1~3 fix acmd23 unwork issue.
> Currently the eMMC chip integrated on i.MX6Q SabreSD boards does not work.
> (It's easily reproduced once you enable usdhc4 on sabresd, see patch 3)
> It's caused by acmd setting bits are never cleared once it's been set
> which cause the next normal commands to work abnormally.
>
> Patch 4~6 fix DDR not supported on SabreSD board.
> The SabreSD board does not have 1.8v signal voltage switch support for uSDHC,
> thus it can not support UHS_DDR50 mode which can only run at 1.8v signal voltage.

Thanks, pushed patches 1-6 to mmc-next for 3.14.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
