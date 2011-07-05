From: sangwook.lee@linaro.org (Sangwook Lee)
Date: Tue, 5 Jul 2011 09:30:31 +0100
Subject: [PATCH 5/7] ARM: EXYNOS4: Use generic DMA PL330 driver
In-Reply-To: <CAGOxZ50-L9X-aGwdi7XyGpJhS-GENmk6Q7XwyD85=OJzs7Juqg@mail.gmail.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
	<1309781915-31549-6-git-send-email-kgene.kim@samsung.com>
	<CAGOxZ50-L9X-aGwdi7XyGpJhS-GENmk6Q7XwyD85=OJzs7Juqg@mail.gmail.com>
Message-ID: <CADPsn1aAhs=DueizDFNCrS4Acxy7SEYtM66ZNKcmVwC5XcdsUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> @@ -47,6 +47,11 @@ static struct clk clk_sclk_usbphy1 = {
>> ? ? ? ?.id ? ? ? ? ? ? = -1,
>> ?};
>>
>> +static struct clk dummy_apb_pclk = {
>> + ? ? ? .name ? ? ? ? ? = "apb_pclk",
>> + ? ? ? .id ? ? ? ? ? ? = -1,
>> +};
>> +
> What is the need to?creating "dummy_apb_pclk"??

I guess this is right, because amba device should call amba_device_reigster and
this function requires apb_pclk, even if that is dummy clock.

>>
>> ?static int exynos4_clksrc_mask_top_ctrl(struct clk *clk, int enable)
