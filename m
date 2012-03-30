From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Fri, 30 Mar 2012 17:33:44 +0900
Subject: [PATCH v6 2/5] Extcon: support generic GPIO extcon driver
In-Reply-To: <4F74E435.9030101@codeaurora.org>
References: <1328856038-21912-1-git-send-email-myungjoo.ham@samsung.com>
 <1330344939-18394-1-git-send-email-myungjoo.ham@samsung.com>
 <1330344939-18394-3-git-send-email-myungjoo.ham@samsung.com>
 <4F74E435.9030101@codeaurora.org>
Message-ID: <CAJ0PZbR3TLoa+UDM7mZLugjfMR_R-j7dKr7dTk0QFy9WM5etMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 7:37 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 02/27/12 04:15, MyungJoo Ham wrote
>> +static irqreturn_t gpio_irq_handler(int irq, void *dev_id)
>> +{
>> + ? ? struct gpio_extcon_data *extcon_data =
>> + ? ? ? ? (struct gpio_extcon_data *)dev_id;
>
> Casting from void is unnecessary.
>
>> +
>> +static int gpio_extcon_probe(struct platform_device *pdev)
>
> __devinit?
>
>> +{
>> + ? ? struct gpio_extcon_platform_data *pdata = pdev->dev.platform_data;
>> + ? ? struct gpio_extcon_data *extcon_data;
>> + ? ? int ret = 0;
> [snip]
>> + ? ? return ret;
>> +}
>> +
>> +static int gpio_extcon_remove(struct platform_device *pdev)
>
> __devexit?
>> +{
>> + ? ? struct gpio_extcon_data *extcon_data = platform_get_drvdata(pdev);
> [snip]
>> +static struct platform_driver gpio_extcon = {
>> + ? ? .probe ? ? ? ? ?= gpio_extcon_probe,
>> + ? ? .remove ? ? ? ? = gpio_extcon_remove,
>
> __devexit_p()?
>> + ? ? .driver ? ? ? ? = {
>> + ? ? ? ? ? ? .name ? = "extcon-gpio",
>> + ? ? ? ? ? ? .owner ?= THIS_MODULE,
>> + ? ? },
>> +};
>> +
>> +module_platform_driver(gpio_extcon);
>> +
>> +MODULE_AUTHOR("Mike Lockwood <lockwood@android.com>");
>> +MODULE_DESCRIPTION("GPIO extcon driver");
>> +MODULE_LICENSE("GPL");
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>

Thank you for the comments.

I'll apply it and test on patchset v8.



Cheers!
MyungJoo.

-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
