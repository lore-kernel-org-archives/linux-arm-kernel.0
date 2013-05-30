From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 30 May 2013 09:41:33 +0200
Subject: [PATCH v3 0/5] rtc-at91rm9200: add shadow interrupt mask
In-Reply-To: <1369298335-24597-1-git-send-email-jhovold@gmail.com>
References: <1364983415-20298-1-git-send-email-jhovold@gmail.com>
 <1369298335-24597-1-git-send-email-jhovold@gmail.com>
Message-ID: <51A702AD.7000507@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/05/2013 10:38, Johan Hovold :
> This is an update of the shadow-interrupt-mask series against v3.10-rc2.
>
> I guess we need Atmel to confirm that all sam9x5 SoCs are indeed
> affected. If not, then some probing mechanism as the one Doug suggested
> could be implemented on top of (a subset of) these patches. What do you
> say, Nicolas?

No probing mechanism is needed: only sam9x5 are affected.

> Note that the first patch (adding a missing OF compile guard) could be
> applied straight away.
>
> Thanks,
> Johan
>
>
> v3:
>   - rebase against v3.10-rc2
>   - remove some comments

Thanks for rebasing this series.

Best regards,

> v2:
>   - rebase on top of DT-support patch by Joachim Eastwood
>   - add missing brace in DT-id table
>
>
> Johan Hovold (5):
>    rtc-at91rm9200: add match-table compile guard
>    rtc-at91rm9200: add configuration support
>    rtc-at91rm9200: refactor interrupt-register handling
>    rtc-at91rm9200: add shadow interrupt mask
>    rtc-at91rm9200: use shadow IMR on at91sam9x5
>
>   .../bindings/rtc/atmel,at91rm9200-rtc.txt          |   2 +-
>   arch/arm/boot/dts/at91sam9x5.dtsi                  |   2 +-
>   drivers/rtc/rtc-at91rm9200.c                       | 131 +++++++++++++++++----
>   3 files changed, 113 insertions(+), 22 deletions(-)
>


-- 
Nicolas Ferre
