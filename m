From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Fri, 5 Sep 2014 09:27:35 +0200
Subject: [PATCH] pinctrl: st: Add remove function and remove gpio_chip
 on failure
In-Reply-To: <5408AA8C.7040100@linaro.org>
References: <1409409935-8775-1-git-send-email-pramod.gurav@smartplayin.com>
 <5408AA8C.7040100@linaro.org>
Message-ID: <540965E7.7040302@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pramod, Srini

On 09/04/2014 08:08 PM, Srinivas Kandagatla wrote:
> Pramod,
> sorry for delay in reply as I was travelling, still in Jet lag.
>> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
>> ---
>>   drivers/pinctrl/pinctrl-st.c |   25 +++++++++++++++++++++++++
>>   1 files changed, 25 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
>> index 5475374..9296845 100644
>> --- a/drivers/pinctrl/pinctrl-st.c
>> +++ b/drivers/pinctrl/pinctrl-st.c
>> @@ -1517,6 +1517,7 @@ static int st_gpiolib_register_bank(struct
>> st_pinctrl *info,
>>                          0, handle_simple_irq,
>>                          IRQ_TYPE_LEVEL_LOW);
>>           if (err) {
>> +            gpiochip_remove(&bank->gpio_chip);
> This change-set looks good.
> IMO, you can send a patch for this change set.

Removing the gpiochip here looks good to me too.

>
>>               dev_info(dev, "could not add irqchip\n");
>>               return err;
>>           }
>> @@ -1685,6 +1686,29 @@ static int st_pctl_probe(struct platform_device
>> *pdev)
>>       return 0;
>>   }
>>
>
>> +static int st_pctl_remove(struct platform_device *pdev)
>> +{
> Ideally this driver will not be removed, as other drivers depend on
> this, even the serial.
>
> so I see no big achievement in adding the remove functionality, as this
> is going to be a dead code and would never be tested.

Agree too.

Thanks,
Maxime
