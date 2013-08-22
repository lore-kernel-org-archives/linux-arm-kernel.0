From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 22 Aug 2013 17:51:40 +0800
Subject: [PATCH v2 2/4] iio: at91: Use different prescal, startup mask
 in MR for different IP
In-Reply-To: <20130815192044.GD12162@lukather>
References: <1376219071-29946-1-git-send-email-josh.wu@atmel.com>
 <1376219071-29946-3-git-send-email-josh.wu@atmel.com>
 <20130815192044.GD12162@lukather>
Message-ID: <5215DF2C.3050502@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Maxime

On 8/16/2013 3:20 AM, Maxime Ripard wrote:
> Hi Josh,
>
> On Sun, Aug 11, 2013 at 07:04:29PM +0800, Josh Wu wrote:
>> For at91 boards, there are different IPs for adc. Different IPs has
>> different STARTUP & PRESCAL mask in ADC_MR.
>>
>> This patch introduce the multiple compatible string for those
>> different IPs.
>>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> Overall it looks like the right ways, but I think we can take it a step
> further.
>
> I'd drop at least the atmel,adc-drdy-mask, atmel,adc-num-channels,
> atmel,adc-status-register, atmel,adc-trigger-register properties (and
> probably the triggers as well description as well).

yeah, right. Currently I want to drop following:

atmel,adc-drdy-mask, atmel,adc-status-register, atmel,adc-trigger-register, atmel,adc-channel-base

For the adc-num-channels, I'd like to leave it in dt parameters. It is a 
description for an adc capablity.

For the triggers, I am not decided. An obvious benifit to remove trigger 
in dt will save many lines of code.

>
> Maxime
>

Best Regards,
Josh Wu
