From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 27 Sep 2011 13:39:58 +0530
Subject: [PATCH v3 2/2] input: samsung-keypad: Add device tree support
In-Reply-To: <20110922174054.GO17168@ponder.secretlab.ca>
References: <1316427553-5033-1-git-send-email-thomas.abraham@linaro.org>
	<1316427553-5033-3-git-send-email-thomas.abraham@linaro.org>
	<20110922174054.GO17168@ponder.secretlab.ca>
Message-ID: <CAJuYYwTgn2KqNr28MNEPEC7eVkuUA-dzVzJHMTy-MV+GBCn=zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On 22 September 2011 23:10, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Mon, Sep 19, 2011 at 03:49:13PM +0530, Thomas Abraham wrote:
>> Add device tree based discovery support for Samsung's keypad controller.
>>
>> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
>> Cc: Donghwa Lee <dh09.lee@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>
> A few things to fix below, but you can add my acked-by when you've
> addressed them.

Ok. Thanks for your review. I will fix as per your comments.

[...]

>
>> diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
>> index f689f49..2a477bc 100644
>> --- a/drivers/input/keyboard/samsung-keypad.c
>> +++ b/drivers/input/keyboard/samsung-keypad.c

[...]

>> +
>> + ? ? of_property_read_u32(np, "samsung,keypad-num-rows", &num_rows);
>> + ? ? of_property_read_u32(np, "samsung,keypad-num-columns", &num_cols);
>
> property_read doesn't touch the values of num_rows or num_cols on
> failure. ?The values need to be initialized if you're going to test
> the result value.

Ok. num_rows and num_cols variables will be set to zero before the
property read call.

>
>> + ? ? if (!num_rows || !num_cols) {
>> + ? ? ? ? ? ? dev_err(dev, "number of keypad rows/columns not specified\n");
>> + ? ? ? ? ? ? return NULL;
>> + ? ? }

[...]

>>
>> + ? ? if (pdev->dev.of_node) {
>> + ? ? ? ? ? ? samsung_keypad_parse_dt_gpio(&pdev->dev, keypad);
>> +#ifdef CONFIG_OF
>> + ? ? ? ? ? ? keypad->type = of_device_is_compatible(pdev->dev.of_node,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "samsung,s5pv210-keypad");
>> +#endif
>
> This still looks odd. ?If you move the #ifdef up one line, then you
> can remove the empty version of samsung_keypad_parse_dt_gpio(), and
> this block won't look so weird.
>

That would be a better approach. Thanks for the suggestion.

Regards,
Thomas.

[...]
