From: dongas86@gmail.com (Dong Aisheng)
Date: Sun, 15 Apr 2012 12:03:16 +0800
Subject: [PATCH 3/3] ARM: imx6q: switch to use pinctrl driver
In-Reply-To: <20120414135331.GB3852@pengutronix.de>
References: <1334333915-1174-1-git-send-email-b29396@freescale.com>
 <1334333915-1174-3-git-send-email-b29396@freescale.com>
 <20120414135331.GB3852@pengutronix.de>
Message-ID: <CAA+hA=QhSUZg0bWTss_4ROwZ--OOQfcP=mpt+MP7-ZKPkEwXyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 14, 2012 at 9:53 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Sat, Apr 14, 2012 at 12:18:35AM +0800, Dong Aisheng wrote:
>> From: Dong Aisheng <dong.aisheng@linaro.org>
>>
>> ---
>> This patch is used for test the new pinctrl driver.
>
> Then please test it with i.MX35, i.MX5...
>
>>
>> + ? ? imx_data->p = pinctrl_get_select_default(&pdev->dev);
>> + ? ? if (IS_ERR(imx_data->p)) {
>> + ? ? ? ? ? ? err = PTR_ERR(imx_data->p);
>> + ? ? ? ? ? ? goto pin_err;
>> + ? ? }
>> +
>
> ... which will fail here.
Sorry, it will not work, it's not a formal patch.
I just sent it quickly for users to try on imx6q.
For MX3 and MX5, before their pinctrl driver are available, user may
need to define a dummy in dt to avoid such an error.

Regards
Dong Aisheng
