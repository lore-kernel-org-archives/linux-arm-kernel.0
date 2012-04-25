From: balajitk@ti.com (T Krishnamoorthy, Balaji)
Date: Wed, 25 Apr 2012 17:24:39 +0530
Subject: [PATCH v2] arm: omap4: hsmmc: check for null pointer
In-Reply-To: <20120423144348.GF26302@arwen.pp.htv.fi>
References: <1335192067-3666-1-git-send-email-balajitk@ti.com>
 <20120423144348.GF26302@arwen.pp.htv.fi>
Message-ID: <CANrkHUak6ehg5+gF05rwfvT10iQzo+5tic8-R6MQkbRjMfnu6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 8:13 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, Apr 23, 2012 at 08:11:07PM +0530, Balaji T K wrote:
>> +int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
>> +{
>> + ? ? struct omap2_hsmmc_info *c;
>> +
>> + ? ? omap_hsmmc_init(controllers);
>> + ? ? for (c = controllers; c->mmc; c++) {
>> + ? ? ? ? ? ? /* pdev can be null if CONFIG_MMC_OMAP_HS is not set */
>> + ? ? ? ? ? ? if (!c->pdev)
>> + ? ? ? ? ? ? ? ? ? ? continue;
>> + ? ? ? ? ? ? omap4_twl6030_hsmmc_set_late_init(&c->pdev->dev);
>> + ? ? }
>> +
>> + ? ? return 0;
>> +}
>
> why are you even calling this if CONFIG_MMC_OMAP_HS isn't set ? Just
> stub it out if you don't have mmc support.

Ok, added in v3
