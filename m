From: megous@megous.com (=?UTF-8?Q?Ond=c5=99ej_Jirman?=)
Date: Sat, 25 Jun 2016 02:56:59 +0200
Subject: [PATCH 03/14] thermal: Add support for sun8i THS on Allwinner H3
In-Reply-To: <CAGb2v65DEgD-mpFMHaWU1XRwBgmQ+=hu2A9EW5u=v0oynGCE1Q@mail.gmail.com>
References: <20160623192104.18720-1-megous@megous.com>
 <20160623192104.18720-4-megous@megous.com>
 <CAGb2v66sFfbD0rTaeeR9CBZFaXLiCKV4DrqKi4Yhc3+u2q+UMw@mail.gmail.com>
 <f6015f63-f8e6-6aa4-aab3-48a8152f0df5@megous.com>
 <CAGb2v65DEgD-mpFMHaWU1XRwBgmQ+=hu2A9EW5u=v0oynGCE1Q@mail.gmail.com>
Message-ID: <7dd9107e-c9ec-595f-4c7d-6226c049a6aa@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.6.2016 02:54, Chen-Yu Tsai wrote:
> On Sat, Jun 25, 2016 at 8:35 AM, Ond?ej Jirman <megous@megous.com> wrote:
>> On 24.6.2016 05:09, Chen-Yu Tsai wrote:
>>>> +static int sun8i_ths_h3_init(struct platform_device *pdev,
>>>> +                            struct sun8i_ths_data *data)
>>>> +{
>>>> +       int ret;
>>>> +       size_t callen;
>>>> +       s32 *caldata;
>>>> +
>>>> +       data->busclk = devm_clk_get(&pdev->dev, "ahb");
>>>> +       if (IS_ERR(data->busclk)) {
>>>> +               ret = PTR_ERR(data->busclk);
>>>> +               dev_err(&pdev->dev, "failed to get ahb clk: %d\n", ret);
>>>> +               return ret;
>>>> +       }
>>>> +
>>>> +       data->clk = devm_clk_get(&pdev->dev, "ths");
>>>> +       if (IS_ERR(data->clk)) {
>>>> +               ret = PTR_ERR(data->clk);
>>>> +               dev_err(&pdev->dev, "failed to get ths clk: %d\n", ret);
>>>> +               return ret;
>>>> +       }
>>>> +
>>>> +       data->reset = devm_reset_control_get(&pdev->dev, "ahb");
>>>
>>> IIRC with the new shared reset control stuff merged, you are supposed
>>> to specify whether you want a shared or exclusive one when you ask for
>>> it.
>>
>> Here devm_reset_control_get will get the exclusive reference. So this
>> should be ok.
> 
> See https://patchwork.kernel.org/patch/9158691/
> 
> The generic ones might be removed later on. I remember in another thread
> it was asked that new users should use the explicit API, and avoid having
> to be converted.

I see, thank you, I'll change that.

regards,
  Ondrej

> ChenYu
> 
>>
>> regards,
>>   Ondrej
>>
>>>
>>> Regards
>>> ChenYu
>>>
>>>> +MODULE_LICENSE("GPL v2");
>>>> --
>>>> 2.9.0
>>>>
>>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160625/e8684941/attachment.sig>
