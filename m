From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 31 May 2016 16:10:09 -0400
Subject: [PATCH 5/6] ARM: dts: exynos: Configure PWM, usb3503, PMIC and
 thermal on Odroid XU board
In-Reply-To: <CAJKOXPfDtp1GLCkQQSKmzRLs4qqwY9Y019rXpUXSeoYQny-sfA@mail.gmail.com>
References: <1464719945-3417-1-git-send-email-krzk@kernel.org>
 <1464719945-3417-5-git-send-email-krzk@kernel.org>
 <1ec0f7fc-f6e0-e4d6-e424-43289bf31b16@osg.samsung.com>
 <CAJKOXPfDtp1GLCkQQSKmzRLs4qqwY9Y019rXpUXSeoYQny-sfA@mail.gmail.com>
Message-ID: <372c8249-b19e-2488-beef-50a0423da757@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/31/2016 04:05 PM, Krzysztof Kozlowski wrote:
> On Tue, May 31, 2016 at 9:36 PM, Javier Martinez Canillas

[snip]

>>
>> I see that LDO 10, 12 and 15 are used by still marked as always-on. Did
>> you try not marking as always-on those or that also causes issues like
>> in the other regulators were you added comments about being always-on?
>>
>> Besides that, patch looks good to me.
> 
> The LDO10 is supplying few more elements (MIPI, HDMI, ADC and
> something called EFNAND). Having it non-always-on still works but
> maybe because I did not test these elements.
> 
> LDO12 and LDO15 supply also VDD10_HSIC and UHOST (used by USB2.0 ports
> and attached on board: usb3503 and lan9730) so if it is not enabled by
> USB 3.0, then they won't work. I guess the usb 2.0 driver should also
> take regulators.
> 
> So overall the board works after removing always-on but it is not
> properly described in DT so I prefer to leave them.
> 

Agreed, thanks a lot for your explanations.

> Best regards,
> Krzysztof

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
