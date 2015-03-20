From: lars@metafoo.de (Lars-Peter Clausen)
Date: Fri, 20 Mar 2015 19:45:35 +0100
Subject: [PATCH 1/4] iio: adc: add support for Berlin
In-Reply-To: <alpine.DEB.2.02.1503201819010.21628@pmeerw.net>
References: <1426858565-31053-1-git-send-email-antoine.tenart@free-electrons.com>
 <1426858565-31053-2-git-send-email-antoine.tenart@free-electrons.com>
 <alpine.DEB.2.02.1503201819010.21628@pmeerw.net>
Message-ID: <550C6ACF.3040902@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2015 06:43 PM, Peter Meerwald wrote:
> Hello Antoine,
>
>> This patch adds the support of the Berlin ADC, available on Berlin SoCs.
>> This ADC has 8 channels available, with one connected to a temperature
>> sensor.
>>
>> The particularity here, is that the temperature sensor connected to the
>> ADC has its own registers, and both the ADC and the temperature sensor
>> must be configured when using it.
>
> some quick comments inline below;
> sometimes this refers to berlin, sometimes to berlin2?
>
> probably these regmap_read() / _write() pairs could be MACRO()'d away
> somehow

There is regmap_update_bits(), which does the read-modify-update cycle.
