From: yadi.brar01@gmail.com (Yadwinder Singh Brar)
Date: Wed, 23 May 2012 09:47:28 +0530
Subject: [PATCH v3 2/2] regulator: Add support for MAX77686.
In-Reply-To: <4FBC4255.4040307@samsung.com>
References: <y@samsung.com> <4fbb2ada.63de440a.589d.78e2@mx.google.com>
 <4FBC4255.4040307@samsung.com>
Message-ID: <CAKew6eVXhg9RscZFM1_go3bjvvn_99zqaDRQ1ZjG_BUWCYR0YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 23, 2012 at 7:20 AM,  <jonghwa3.lee@samsung.com> wrote:
> Hi, again.
> On 2012? 05? 22? 14:57, yadi.brar01 at gmail.com wrote:
>
>
>> +static __devinit int max77686_pmic_probe(struct platform_device *pdev)
>> +{
>
>> +
>> + ? ? for (i = 0; i < pdata->num_regulators; i++) {
>> + ? ? ? ? ? ? config.dev = max77686->dev;
>> + ? ? ? ? ? ? config.init_data = pdata->regulators[i].init_data;
>> + ? ? ? ? ? ? config.driver_data = max77686;
>> + ? ? ? ? ? ? config.regmap = iodev->regmap;
>> +
>> + ? ? ? ? ? ? rdev[i] = regulator_register(&regulators[i], &config);
>
>
> I'm sorry that i missed one. You have to register all regulators
> unconditionally. Mark brown commented about this to my former patch.
>
> 'No, you should unconditionally register all regulators the device
> physically has. ?This is useful for debug and simplifies the code.'
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?- from Mark Brown
>

Yes, we are registering all regulators here.
As pdata->num_regulators will be equal to ARRAY_SIZE(regulators)

Thanks,
Yadwinder.
