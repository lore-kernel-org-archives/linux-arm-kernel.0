From: phh@phh.me (Pierre-Hugues Husson)
Date: Fri, 20 Oct 2017 21:21:14 +0200
Subject: [PATCH 1/3] drm: bridge: synopsys/dw-hdmi: Enable cec clock
In-Reply-To: <20171020081203.GD20805@n2100.armlinux.org.uk>
References: <20171013225337.5196-1-phh@phh.me>
 <20171013225337.5196-2-phh@phh.me>
 <20171020081203.GD20805@n2100.armlinux.org.uk>
Message-ID: <CAJ-oXjR7OyGjppoGReiaibLaZa6427ppwnbEQ2pvxMV2PKOHjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-10-20 10:12 GMT+02:00 Russell King - ARM Linux <linux@armlinux.org.uk>:
> On Sat, Oct 14, 2017 at 12:53:35AM +0200, Pierre-Hugues Husson wrote:
>> @@ -2382,6 +2383,18 @@ __dw_hdmi_probe(struct platform_device *pdev,
>>               goto err_isfr;
>>       }
>>
>> +     hdmi->cec_clk = devm_clk_get(hdmi->dev, "cec");
>> +     if (IS_ERR(hdmi->cec_clk)) {
>> +             hdmi->cec_clk = NULL;
>
> What if devm_clk_get() returns EPROBE_DEFER?  Does that really mean the
> clock does not exist?
Should be fixed in v2.
Thanks
