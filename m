From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Oct 2014 09:52:13 +0200
Subject: [PATCH v2 2/2] arm: pm: add deep sleep support for LS1
In-Reply-To: <1414037773-7735-2-git-send-email-chenhui.zhao@freescale.com>
References: <1414037773-7735-1-git-send-email-chenhui.zhao@freescale.com>
 <1414037773-7735-2-git-send-email-chenhui.zhao@freescale.com>
Message-ID: <10927226.rVoqeXCnhH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 October 2014 12:16:13 Chenhui Zhao wrote:
> +extern void ls1_do_deepsleep(unsigned long addr);
> +extern void ls1_start_fsm(void);
> +extern void ls1_deepsleep_resume(void);
> +extern void ls1021a_set_secondary_entry(void);
> +extern int ls1_sram_code_size;
> +extern void fsl_epu_setup_default(void __iomem *epu_base);
> +

Please move these into a header file out of principle. I realize they
are defined in an assembly file, so the change won't actually add
any type safety as it would for functions defined in C files, but it's
better to be consistent.

	Arnd
