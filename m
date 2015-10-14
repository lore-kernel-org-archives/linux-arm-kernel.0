From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 14 Oct 2015 10:01:15 +0100
Subject: [PATCH 1/2] ARM: dts: fix gpio-keys wakeup-source property
In-Reply-To: <20151014001351.GB24693@verge.net.au>
References: <1444743164-17735-1-git-send-email-sudeep.holla@arm.com>
 <20151014001351.GB24693@verge.net.au>
Message-ID: <561E19DB.8040701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/10/15 01:13, Simon Horman wrote:
> [cc linux-sh]
>
> On Tue, Oct 13, 2015 at 02:32:43PM +0100, Sudeep Holla wrote:
>> The keyboard driver for GPIO buttons(gpio-keys) checks for one of the
>> two boolean properties to enable gpio buttons as wakeup source:
>> 1. "wakeup-source" or
>> 2. the legacy "gpio-key,wakeup"
>>
>> However juno, ste-snowball and emev2-kzm9d dts file have a undetected
>> "wakeup" property to indictate the wakeup source.
>>
>> This patch fixes it by making use of "wakeup-source" property.
>>
>> Cc: Simon Horman <horms@verge.net.au>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   arch/arm/boot/dts/emev2-kzm9d.dts             |  8 ++++----
>>   arch/arm/boot/dts/ste-snowball.dts            | 10 +++++-----
>>   arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 12 ++++++------
>>   3 files changed, 15 insertions(+), 15 deletions(-)
>
> emev2-kzm9d portion:
>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
>
> My preferred course of action would be to take that portion through the
> renesas tree if it was broken out into a separate patch. But I won't
> object if someone wants to take the whole patch/series.

I can split this patch, but it is more like a bug fix IMO, I can't use
these GPIO as wakeup on Juno. So I hope arm-soc guys take it directly.
If not, I can split and sent it separately.

-- 
Regards,
Sudeep
