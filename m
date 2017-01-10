From: andi.shyti@samsung.com (Andi Shyti)
Date: Wed, 11 Jan 2017 07:45:43 +0900
Subject: [PATCH v2 2/2] media: rc: add driver for IR remote receiver on
 MT7623 SoC
In-Reply-To: <201701102015.fSM15CvI%fengguang.wu@intel.com>
References: <CGME20170110120828epcas4p42482b7920c7a7dabd4c7794959f6d264@epcas4p4.samsung.com>
 <201701102015.fSM15CvI%fengguang.wu@intel.com>
Message-ID: <20170110224543.uuoa7ofkvolz6inp@gangnam.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

>    include/linux/compiler.h:253:8: sparse: attribute 'no_sanitize_address': unknown attribute
> >> drivers/media/rc/mtk-cir.c:215:41: sparse: too many arguments for function devm_rc_allocate_device
>    drivers/media/rc/mtk-cir.c: In function 'mtk_ir_probe':
>    drivers/media/rc/mtk-cir.c:215:11: error: too many arguments to function 'devm_rc_allocate_device'
>      ir->rc = devm_rc_allocate_device(dev, RC_DRIVER_IR_RAW);
>               ^~~~~~~~~~~~~~~~~~~~~~~
>    In file included from drivers/media/rc/mtk-cir.c:22:0:
>    include/media/rc-core.h:213:16: note: declared here
>     struct rc_dev *devm_rc_allocate_device(struct device *dev);
>                    ^~~~~~~~~~~~~~~~~~~~~~~
> 
> vim +/devm_rc_allocate_device +215 drivers/media/rc/mtk-cir.c
> 
>    209		ir->base = devm_ioremap_resource(dev, res);
>    210		if (IS_ERR(ir->base)) {
>    211			dev_err(dev, "failed to map registers\n");
>    212			return PTR_ERR(ir->base);
>    213		}
>    214	
>  > 215		ir->rc = devm_rc_allocate_device(dev, RC_DRIVER_IR_RAW);

this error comes because the patches I pointed out have not been
applied yet. I guess you can ignore them as long as you tested
yours on top those patches.

Andi
