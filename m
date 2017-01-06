From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 06 Jan 2017 12:43:46 +0900
Subject: [PATCH 2/2] media: rc: add driver for IR remote receiver on MT7623
 SoC
In-Reply-To: <1483632384-8107-3-git-send-email-sean.wang@mediatek.com>
References: <1483632384-8107-1-git-send-email-sean.wang@mediatek.com>
 <CGME20170105160810epcas3p1b7a85197c15fbbe87e08c736259935d6@epcas3p1.samsung.com>
 <1483632384-8107-3-git-send-email-sean.wang@mediatek.com>
Message-ID: <20170106034346.7njhyhtsc4yado5c@gangnam.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

> +	ir->rc = rc_allocate_device();

Yes, you should use devm_rc_allocate_device(...)

Besides, standing to this patch which is not in yet:

https://lkml.org/lkml/2016/12/18/39

rc_allocate_device should provide the driver type during
allocation, so it should be:

	ir->rc = rc_allocate_device(RC_DRIVER_IR_RAW);

and this line can be removed:

> +	ir->rc->driver_type = RC_DRIVER_IR_RAW;

I don't know when Mauro will take the patch above.

Andi
