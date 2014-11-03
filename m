From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Nov 2014 11:00:45 +0100
Subject: [PATCH v2] ARM: BCM5301X: set customized AUXCTL
In-Reply-To: <1414852899-30947-1-git-send-email-hauke@hauke-m.de>
References: <1414851912-30630-1-git-send-email-hauke@hauke-m.de>
 <1414852899-30947-1-git-send-email-hauke@hauke-m.de>
Message-ID: <64693192.oy48jMW2b1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 01 November 2014 15:41:38 Hauke Mehrtens wrote:
>  };
>  
>  DT_MACHINE_START(BCM5301X, "BCM5301X")
> -       .l2c_aux_val    = 0,
> +       .l2c_aux_val    = L310_AUX_CTRL_CACHE_REPLACE_RR |
> +                         L310_AUX_CTRL_DATA_PREFETCH |
> +                         L310_AUX_CTRL_INSTR_PREFETCH |
> +                         L310_AUX_CTRL_EARLY_BRESP,

Please put these into the dts file instead if the boot loader fails
to set them correctly. We should not override them from source code
for new platforms any more.

	Arnd
