From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 20 Oct 2010 18:13:10 +0900
Subject: [PATCH 4/4] ARM: S5PV310: Add audio platform devices
In-Reply-To: <05cf01cb7031$b558df80$200a9e80$%kim@samsung.com>
References: <1287472517-563-1-git-send-email-jassisinghbrar@gmail.com>
	<05cf01cb7031$b558df80$200a9e80$%kim@samsung.com>
Message-ID: <AANLkTikAbKgbEtT3O=9iFNiB6nXBhkx1XvvrmzbDAoax@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 20, 2010 at 5:35 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:

>> + ? ? /* configure GPIO for i2s port */
>> + ? ? switch (pdev->id) {
>> + ? ? case 0:
>> + ? ? ? ? ? ? s3c_gpio_cfgpin(S5PV310_GPZ(0), S3C_GPIO_SFN(2));
>> + ? ? ? ? ? ? s3c_gpio_cfgpin(S5PV310_GPZ(1), S3C_GPIO_SFN(2));
>> + ? ? ? ? ? ? s3c_gpio_cfgpin(S5PV310_GPZ(2), S3C_GPIO_SFN(2));
>> + ? ? ? ? ? ? s3c_gpio_cfgpin(S5PV310_GPZ(3), S3C_GPIO_SFN(2));
>> + ? ? ? ? ? ? s3c_gpio_cfgpin(S5PV310_GPZ(4), S3C_GPIO_SFN(2));
>> + ? ? ? ? ? ? s3c_gpio_cfgpin(S5PV310_GPZ(5), S3C_GPIO_SFN(2));
>> + ? ? ? ? ? ? s3c_gpio_cfgpin(S5PV310_GPZ(6), S3C_GPIO_SFN(2));
>
> s3c_gpio_cfgpin_range(S5PV310_GPZ(0), 7, S3C_GPIO_SFN(2));

OK

>> +static struct resource s5pv310_iis0_resource[] = {
>> + ? ? [0] = {
>> + ? ? ? ? ? ? .start = S5PV310_PA_IIS0,
> ? ? ? ? ? ? ? ? ? ? ?^
>> + ? ? ? ? ? ? .end ? = S5PV310_PA_IIS0 + 0x100 - 1,
> ? ? ? ? ? ? ? ? ? ?^^^
>> + ? ? ? ? ? ? .flags = IORESOURCE_MEM,
> ? ? ? ? ? ? ? ? ? ? ?^
>
> It would be better if you could use tab above like following.

OK


>> +
>> +struct platform_device s5pv310_device_iis0 = {
>> + ? ? .name ? ? ? ? ? ? = "samsung-i2s",
>> + ? ? .id ? ? ? ? ? ? ? = 0,
>> + ? ? .num_resources ? ?= ARRAY_SIZE(s5pv310_iis0_resource),
>> + ? ? .resource ? ? ? ? = s5pv310_iis0_resource,
>> + ? ? .dev = {
>> + ? ? ? ? ? ? .platform_data = &i2sv5_pdata,
>> + ? ? },
>> +};
>> +
>
> I'm thinking about the name of IIS/I2S...Hmm...

I2S is more popular, but our manuals use both I2S and IIS.
IIS is present in code mostly due to historical reason.
