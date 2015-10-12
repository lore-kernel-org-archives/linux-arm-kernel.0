From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 12 Oct 2015 15:44:35 +0200
Subject: [PATCH v3 1/7] mmc: core: move ocr-bit to voltage translation
 into separate function
In-Reply-To: <201510122154.fUL0WlRf%fengguang.wu@intel.com>
References: <201510122154.fUL0WlRf%fengguang.wu@intel.com>
Message-ID: <1669315.MIcYHSjc3k@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Montag, 12. Oktober 2015, 21:26:04 schrieb kbuild test robot:
> [auto build test WARNING on rockchip/for-next -- if it's inappropriate base,
> please suggest rules for selecting the more suitable base]
> 
> url:   
> https://github.com/0day-ci/linux/commits/Heiko-Stuebner/mmc-dw_mmc-rockchip
> -allow-tuning-using-the-clk-phase-api/20151012-205613 config:
> x86_64-randconfig-x011-10121751 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
> 
> All warnings (new ones prefixed by >>):
> >> drivers/mmc/core/core.c:1277:12: warning: 'mmc_ocrbitnum_to_vdd' defined
> >> but not used [-Wunused-function]
>     static int mmc_ocrbitnum_to_vdd(int vdd_bit, int *min_uV, int *max_uV)
>                ^

I'm not 100% sure I understand that warning. Is it just because we're ignoring 
the return value in the current first user of the function? [Which is done, 
because we already tested for the vdd_bit != 0 just before invoking 
mmc_ocrbitnum_to_vdd .

The second user added in the following patch then checks the return value. So 
I guess this should stay as it is? I guess Ulf's call - maybe he wants it 
differently anyway ;-) .


Heiko
