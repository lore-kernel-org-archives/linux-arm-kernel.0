From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 11 Nov 2012 19:40:43 +0100
Subject: [PATCH v2] pinctrl/nomadik: make independent of prcmu driver
In-Reply-To: <509D3A53.6080007@wwwdotorg.org>
References: <1352456915-28738-1-git-send-email-linus.walleij@stericsson.com>
 <509D3A53.6080007@wwwdotorg.org>
Message-ID: <CACRpkdZz8_SVK6ERaXXTs5d8OBBkYY8e7uwx_dmAXkwV2iPovQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 9, 2012 at 6:16 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> [Me]
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     if (res) {
>> +             npct->prcm_base = devm_ioremap(&pdev->dev, res->start,
>> +                                            resource_size(res));
>> +             if (!npct->prcm_base) {
>> +                     dev_err(&pdev->dev,
>> +                             "failed to ioremap PRCM registers\n");
>> +                     return -ENOMEM;
>> +             }
>> +     } else {
>> +             dev_info(&pdev->dev,
>> +                      "No PRCM base, assume no ALT-Cx control is available\n");
>> +     }
>
> Where is "assume no ALT-Cx control is available" implemented; I don't
> see anything that uses npct->prcm_base to conditionally enable/block any
> features. Is it just assumed that the DT won't contain any entries that
> trigger writes to the PRCM registers? That seems fragile; it could cause
> a "user"-triggered kernel crash.

Yeah. That's been in for a while, so this patch in itself is not making
things more fragile, it came with the first Alt-Cx patch.
So it is indeed based on good faith in the maps.

I'm poking Jean-Nicolas to have a look at hardening
this with some check, ping!

> Aside from that, this seems fine. Much smaller than V1:-)

Yeah, thanks for poking us...

Yours,
Linus Walleij
