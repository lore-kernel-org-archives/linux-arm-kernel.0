From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 03 Sep 2012 10:54:06 +0200
Subject: [PATCH] ARM: S3C24XX: Add WIZnet W5300E01-ARM board support
In-Reply-To: <CA+E=qVfGN9_Lj5GWqERfZGQsTtnnK_fARgXuCujdVeZ0PBoJEQ@mail.gmail.com>
References: <1346653236-19728-1-git-send-email-kth3321@gmail.com>
 <CA+E=qVfGN9_Lj5GWqERfZGQsTtnnK_fARgXuCujdVeZ0PBoJEQ@mail.gmail.com>
Message-ID: <5044702E.3070209@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/03/2012 09:56 AM, Vasily Khoruzhick wrote:
>> +static void __init w5300e01_init(void)
>> +{
>> +       s3c_nand_set_platdata(&w5300e01_nand_info);
>> +       platform_add_devices(w5300e01_devices, ARRAY_SIZE(w5300e01_devices));
>> +
>> +       /* W5300 interrupt pin. */
>> +       s3c2410_gpio_cfgpin(S3C2410_GPF(0), S3C2410_GPIO_IRQ);
>> +
>> +       s3c2410_gpio_cfgpin(S3C2410_GPF(4), S3C2410_GPIO_OUTPUT);
>> +       s3c2410_gpio_cfgpin(S3C2410_GPF(5), S3C2410_GPIO_OUTPUT);
>> +       s3c2410_gpio_cfgpin(S3C2410_GPF(6), S3C2410_GPIO_OUTPUT);
>> +       s3c2410_gpio_cfgpin(S3C2410_GPF(7), S3C2410_GPIO_OUTPUT);
>> +
>> +       s3c2410_gpio_setpin(S3C2410_GPF(0), 1);
>> +       s3c2410_gpio_setpin(S3C2410_GPF(4), 1);
>> +       s3c2410_gpio_setpin(S3C2410_GPF(5), 1);
>> +       s3c2410_gpio_setpin(S3C2410_GPF(6), 1);
>> +       s3c2410_gpio_setpin(S3C2410_GPF(7), 1);
>> +
> 
> Please use gpiolib API, legacy s3c2410_gpio_* API will be removed soon.

Right, you'll find some information about this in
Documentation/arm/Samsung-S3C24XX/GPIO.txt.

These links may be useful as well:
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg11985.html
http://www.spinics.net/lists/arm-kernel/msg192119.html

--

Regards,
Sylwester
