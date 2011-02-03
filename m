From: kishon@ti.com (ABRAHAM, KISHON VIJAY)
Date: Thu, 3 Feb 2011 16:58:44 +0530
Subject: [PATCHv2 1/2] ads7846: OMAP3: Removal of warnings backtrace in
	bootup
In-Reply-To: <4D4A8DA0.1010806@compulab.co.il>
References: <1296726514-32146-1-git-send-email-sourav.poddar@ti.com>
	<4D4A7F13.8080502@compulab.co.il> <4D4A80D3.2060407@compulab.co.il>
	<AANLkTi=U1qo=udB=tMyuA2HcnCS4EmreaVDbw2vQ9dY8@mail.gmail.com>
	<4D4A8DA0.1010806@compulab.co.il>
Message-ID: <AANLkTikgJck30XBMJN-8v2Di0pykHkxP8d_mRrZnYUs_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 3, 2011 at 4:42 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>
>
> On 02/03/11 13:00, Poddar, Sourav wrote:
>
>> On Thu, Feb 3, 2011 at 3:47 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>>> if (pdata->get_pendown_state) {
>>> ? ? ? ?ts->get_pendown_state = pdata->get_pendown_state;
>>> ? ? ? ?ts->gpio_pendown = -1;
>>> ? ? ? ?return 0;
>>> }
>> Yes we can do so .I initialise it at a place where other variables
>> ?where initialised.
>>
>>>> Also, why don't we use -EINVAL for the invalid gpio number instead of -1 constant?
>>>>
>> ?I used -1 because conditional check done in probe ads7846_probe function
>> ?used this value.
>>
>> ? err_free_gpio:
>> ? ? ? ? if (ts->gpio_pendown != -1)
>> ? ? ? ? ? ? ? ? gpio_free(ts->gpio_pendown);
>>
>
> Well I understand that and that's why in my proposal I used -1 also, but
> I thought we can make it even better if we switch to -EINVAL
> (though wanted to check if there are any reasonable objections)
> and while you are at this, may be you are willing also to submit a patch for this?

  I guess instead of -EINVAL, -EIO should be initialized to
ts->gpio_pendown since that
  would be more appropriate for gpio and as Balbi suggested it would
be better to use
  gpio_is_valid() for checking this error condition.

  -Kishon

>
> --
> Regards,
> Igor.
>
>
