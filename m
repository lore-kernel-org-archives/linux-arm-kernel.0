From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 10 Apr 2013 19:10:44 +0900
Subject: [PATCH] pinctrl: Add pinctrl-s3c24xx driver
In-Reply-To: <201304100135.12471.heiko@sntech.de>
References: <201304100135.12471.heiko@sntech.de>
Message-ID: <30fe01ce35d3$a9b7ce10$fd276a30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> The s3c24xx pins follow a similar pattern as the other Samsung SoCs and
> can therefore reuse the already introduced infrastructure.
> 
> The s3c24xx SoCs have one design oddity in that the first 4 external
> interrupts do not reside in the eint pending register but in the main
> interrupt controller instead. We solve this by forwarding the external
> interrupt from the main controller into the irq domain of the pin bank.
> The masking/acking of these interrupts is handled in the same way.
> 
> Furthermore the S3C2412/2413 SoCs contain another oddity in that they
> keep the same 4 eints in the main interrupt controller and eintpend
> register and requiring ack operations to happen in both. To solve this
> a ctrl_type enum is introduced which can keep the type of controller
> in the samsung_pin_ctrl struct for later retrieval.
> 
> The ctrl_type enum contains only S3C24XX and S3C2412 types, as the
> eint-speciality is currently the only use-case. But it can be expaned
> if other SoCs gain special handling requirements later on.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Looks good to me, need to implement more for other s3c24xx though.

Linus, if you want, please add:

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

- Kukjin
