From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 18 Oct 2009 01:01:47 -0400
Subject: [PATCH] pxa: extend gpio pins from 128 to 256
In-Reply-To: <f17812d70910150401q425b47e2hb4da64bb203dc770@mail.gmail.com>
References: <771cded00909250339g1b894557v6cabf978fa11e470@mail.gmail.com>
	<f17812d70910150401q425b47e2hb4da64bb203dc770@mail.gmail.com>
Message-ID: <771cded00910172201k6cf7c8c7ue7485c4c876e8123@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2009 at 7:01 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> Haojian,
>
> Sorry for late reply. See my comments below:
>
>> Subject: [PATCH] pxa: extend gpio pins from 128 to 256
>>
>> GPIO pins exceeds 128 pins. So extend the maximum GPIO pins to 256.
>> And extend MFP pins also.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> ---
>> diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach-pxa/mfp-pxa2xx.c
>> index cf6b720..767db92 100644
>> --- a/arch/arm/mach-pxa/mfp-pxa2xx.c
>> +++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
>> @@ -41,7 +41,7 @@ struct gpio_desc {
>> ???? unsigned long??? config;
>> ?};
>>
>> -static struct gpio_desc gpio_desc[MFP_PIN_GPIO127 + 1];
>> +static struct gpio_desc gpio_desc[MFP_PIN_GPIO255 + 1];
>>
>
> I'm not sure if this is really necessary since mfp-pxa2xx.c is pxa2xx specific,
> and extending the array by double means wasting of space?
>
>> ?static unsigned long gpdr_lpm[4];
>>
>> @@ -117,7 +117,7 @@ static inline int __mfp_validate(int mfp)
>> ?{
>> ???? int gpio = mfp_to_gpio(mfp);
>>
>> -??? if ((mfp > MFP_PIN_GPIO127) || !gpio_desc[gpio].valid) {
>> +??? if ((mfp > MFP_PIN_GPIO255) || !gpio_desc[gpio].valid) {
>> ???? ??? pr_warning("%s: GPIO%d is invalid pin\n", __func__, gpio);
>> ???? ??? return -1;
>> ???? }
>
> Same here, pxa2xx specific.
>

Up to now, mfp driver is shared between pxa2xx, pxa3xx and so on. It
seems that extending mfp io is easier.

Otherwise, we may need to create new mfp driver on pxa935 and new chips.

Thanks
Haojian
