From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Oct 2015 23:18:53 +0200
Subject: [PATCH v2 7/7] clk: ns2: add clock support for Broadcom Northstar
 2 SoC
In-Reply-To: <1444770485-11210-8-git-send-email-jonmason@broadcom.com>
References: <1444770485-11210-1-git-send-email-jonmason@broadcom.com>
 <1444770485-11210-8-git-send-email-jonmason@broadcom.com>
Message-ID: <5280890.6npshDUNFZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 October 2015 17:08:05 Jon Mason wrote:
> @@ -3,6 +3,7 @@ obj-$(CONFIG_CLK_BCM_KONA)      += clk-kona-setup.o
>  obj-$(CONFIG_CLK_BCM_KONA)     += clk-bcm281xx.o
>  obj-$(CONFIG_CLK_BCM_KONA)     += clk-bcm21664.o
>  obj-$(CONFIG_COMMON_CLK_IPROC) += clk-iproc-armpll.o clk-iproc-pll.o clk-iproc-asiu.o
> +obj-$(CONFIG_COMMON_CLK_IPROC) += clk-ns2.o
>  obj-$(CONFIG_ARCH_BCM_CYGNUS)  += clk-cygnus.o
>  obj-$(CONFIG_ARCH_BCM_NSP)     += clk-nsp.o
>  obj-$(CONFIG_ARCH_BCM_5301X)   += clk-nsp.o

If I understand this right, both CYGNUS and NS2 are IPROC based, but it
looks like you now require building the clk-ns2 file for both?

On a related note, I'm seeing problems when CONFIG_CYGNUS is set but
CONFIG_COMMON_CLK_IPROC is disabled, as that currently leads to a link
failure.

	Arnd
