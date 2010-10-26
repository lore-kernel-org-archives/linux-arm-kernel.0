From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 26 Oct 2010 14:30:49 +0900
Subject: [PATCH 9/9] ARM: S5PV310: Add audio platform devices
In-Reply-To: <AANLkTikJDD1qeP2KouLhwmYgcVpr4P3S2yZUfBjZgQCD@mail.gmail.com>
References: <1288057281-25635-1-git-send-email-jassisinghbrar@gmail.com>
	<AANLkTikMG2AqmdxL7diXq9iuBK-AmgU_e4rzkekHA+td@mail.gmail.com>
	<AANLkTimcj8i44K2xX8cW0Gm_N5WbQzs6GCBuR2Rs0Qph@mail.gmail.com>
	<AANLkTikJDD1qeP2KouLhwmYgcVpr4P3S2yZUfBjZgQCD@mail.gmail.com>
Message-ID: <AANLkTi=xdW9Qct5qRr4wkdfvwTbeKwn+RnrbC97VLbBd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 26, 2010 at 1:59 PM, Kyungmin Park <kmpark@infradead.org> wrote:

>>>> +static int s5pv310_cfg_i2s(struct platform_device *pdev)
>>>> +{
>>>> + ? ? ? /* configure GPIO for i2s port */
>>>> + ? ? ? switch (pdev->id) {
>>>> + ? ? ? case 0:
>>>> + ? ? ? ? ? ? ? s3c_gpio_cfgpin_range(S5PV310_GPZ(0), 7, S3C_GPIO_SFN(2));
>>> Does it default setup for i2s? In my board some pins are used for
>>> other purpose.
>>> I mean GPZ(1, 5, 6) doesn't used it for I2S.
>>> then how do you handle this one?
>> At least in the manual that I have, I2S0 is possible only on GPZ[0:6],
>> so if a user
>> does attempt to use I2S0, he/she shouldn't touch the GPIOs for any
>> other purpose.
> No C110 use the same scheme. and works
>> Please let me know details of your board if you think there is some problem
>> with this setup.
> As above it doesn't use the GPZ(1,5,6) and used for other purpose.
> and these are already checked by LSI H/W team.

Ok, so you mean running I2S0 in 2channel, rather than 6 channel mode.
We don't support that yet but that should be easy to implement by
defining custom i/f between platform and machine init code.
