From: hs@denx.de (Heiko Schocher)
Date: Tue, 07 Aug 2012 16:34:40 +0200
Subject: [PATCH v6] ARM: mtd: nand: davinci: add OF support for davinci
 nand controller
In-Reply-To: <1343632944-25971-1-git-send-email-hs@denx.de>
References: <1343632944-25971-1-git-send-email-hs@denx.de>
Message-ID: <50212780.5000809@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 30.07.2012 09:22, Heiko Schocher wrote:
> add OF support for the davinci nand controller.
>
> Signed-off-by: Heiko Schocher<hs@denx.de>
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: linux-mtd at lists.infradead.org
> Cc: David Woodhouse<dwmw2@infradead.org>
> Cc: Grant Likely<grant.likely@secretlab.ca>
> Cc: Sekhar Nori<nsekhar@ti.com>
> Cc: Wolfgang Denk<wd@denx.de>
> Cc: Scott Wood<scottwood@freescale.com>
>
> ---
> - changes for v2:
>    - add comments from Scott Wood:
>      - add "ti,davinci-" prefix
>      - Dashes are preferred to underscores
>      - rename "nandflash" to "nand"
>      - introduce new "ti,davinci" specific properties for setting
>        up ecc_mode, ecc_bits, options and bbt options, instead
>        using linux defines
>      - readme fixes
> - no changes for v3
> - changes for v4
>    remove "pinmux-handle" property as discussed here:
>    http://www.spinics.net/lists/arm-kernel/msg175701.html
>    with Nori Sekhar
> - no changes for v5
>
> - changes for v6:
>    add comments from Sekhar Nori:
>    - remove unnecessary includes
>    - use devm_kzalloc instead of kzalloc
>    - remove AEMIF timing specific bindings, as
>      this has to be done later.
>
>   .../devicetree/bindings/arm/davinci/nand.txt       |   51 ++++++++++++++
>   drivers/mtd/nand/davinci_nand.c                    |   72 +++++++++++++++++++-
>   2 files changed, 122 insertions(+), 1 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/arm/davinci/nand.txt

ping ... any comments?

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
