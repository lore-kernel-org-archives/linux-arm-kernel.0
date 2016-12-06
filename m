From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 6 Dec 2016 10:57:21 -0500 (EST)
Subject: [PATCH 1/1] arm/module: maximum utilization of module area.
In-Reply-To: <1481012975-44478-1-git-send-email-maninder1.s@samsung.com>
References: <1481012975-44478-1-git-send-email-maninder1.s@samsung.com>
Message-ID: <alpine.LFD.2.20.1612061053470.1657@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Dec 2016, Maninder Singh wrote:

> This patch defines new macro MODULE_START to ensure kernel text
> and module remains within 32 MB of address range.
> 
> Tried this patch by inserting 20 MB size module on 4.1 kernel:-
> 
> Earlier:-
> ==========
> sh# insmod size.ko
> ....
> insmod: ERROR: could not insert module size.ko: Cannot allocate memory
> sh#
> 
> With this patch
> ===============
> sh# insmod size.ko
> ...
> sh# lsmod
> Module                  Size  Used by
> size                20972425  0

Could you please try enabling CONFIG_ARM_MODULE_PLTS instead of this 
patch?


Nicolas
