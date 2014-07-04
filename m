From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 04 Jul 2014 13:00:36 +0200
Subject: [PATCH 2/6] pinctrl: samsung: Handle GPIO request and free using
 pinctrl helpers
In-Reply-To: <CAK5sBcFHFg7u-40NVovp9D2ro=MnQbOyiP6MtMss2PJmByR4iQ@mail.gmail.com>
References: <1404315664-3174-1-git-send-email-t.figa@samsung.com>
 <1404315664-3174-3-git-send-email-t.figa@samsung.com>
 <CAK5sBcFHFg7u-40NVovp9D2ro=MnQbOyiP6MtMss2PJmByR4iQ@mail.gmail.com>
Message-ID: <53B68954.30300@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.07.2014 11:41, Sachin Kamat wrote:
> Hi Tomasz,
> 
> On Wed, Jul 2, 2014 at 9:11 PM, Tomasz Figa <t.figa@samsung.com> wrote:
>> This patch adds .request() and .free() operations to gpio_chip of
>> pinctrl-samsung driver, which call pinctrl request and free helpers to
>> request and free pinctrl pin along with GPIO pin.
>>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>> ---
>>  drivers/pinctrl/pinctrl-samsung.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
>> index 779c8bc..6e099d6 100644
>> --- a/drivers/pinctrl/pinctrl-samsung.c
>> +++ b/drivers/pinctrl/pinctrl-samsung.c
>> @@ -779,7 +779,8 @@ static int samsung_pinctrl_register(struct platform_device *pdev,
>>                 pin_bank = &drvdata->ctrl->pin_banks[bank];
>>                 pin_bank->grange.name = pin_bank->name;
>>                 pin_bank->grange.id = bank;
>> -               pin_bank->grange.pin_base = pin_bank->pin_base;
>> +               pin_bank->grange.pin_base = drvdata->ctrl->base
>> +                                               + pin_bank->pin_base;
> 
> Is this a fix?
> 

Hmm, could be.

I haven't observed any issues due to this without further patches from
this series, so I'm not sure if this needs to be sent as a separate fix,
but I might split this patch into two if necessary.

Best regards,
Tomasz
