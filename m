From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 14 Nov 2013 08:48:35 -0200
Subject: [PATCH 1/2] chipidea: ci_hdrc_imx: Allow handling the clock for
 an USB phy/hub
In-Reply-To: <20131114095658.GY16735@n2100.arm.linux.org.uk>
References: <1384394987-15134-1-git-send-email-festevam@gmail.com>
 <20131114095658.GY16735@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5B7SVL2cUm2i2dT1mwmxVPBEZ2vWbm00vosi0AByxwoXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 7:56 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Nov 14, 2013 at 12:09:46AM -0200, Fabio Estevam wrote:
>> @@ -107,10 +108,22 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>>               return ret;
>>       }
>>
>> +     data->clk_phy = devm_clk_get(&pdev->dev, "phy");
>> +     if (IS_ERR(data->clk_phy)) {
>> +             data->clk_phy = NULL;
>> +     } else {
>
> Please stop using NULL as a indicator with functions which only return
> failure as an error pointer.  Replace the above three lines with

Thanks, fixed it in v2.
