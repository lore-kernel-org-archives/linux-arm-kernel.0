From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 30 Apr 2015 08:58:16 -0700
Subject: [PATCH 2/2] ARM: dts: Fix pinctrl settings for S2MPS11 RTC alarm
 IRQ on Arndale Octa
In-Reply-To: <CAJKOXPfbsrkvXT_CBxZeDTLYdbwGMH=+5mnBLoy9Yfyp4thVQg@mail.gmail.com>
 (Krzysztof Kozlowski's message of "Fri, 17 Apr 2015 22:30:38 +0900")
References: <1427985376-20420-1-git-send-email-k.kozlowski@samsung.com>
 <1427985376-20420-3-git-send-email-k.kozlowski@samsung.com>
 <CAJKOXPfbsrkvXT_CBxZeDTLYdbwGMH=+5mnBLoy9Yfyp4thVQg@mail.gmail.com>
Message-ID: <7hy4l9liav.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzystof,

Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:

> 2015-04-02 23:36 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
>> On Arndale Octa the S2MPS11 RTC alarm interrupt was not handled at all
>> because of wrong configuration of interrupt and gpx3-2.
>> 1. Interrupt is signaled by falling edge.
>> 2. This GPIO line is hard-wired on the board to PVDD_APIO_1V8 through a
>>    resistor so pull-up/down must be disabled.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5420-arndale-octa.dts | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> Dear Kukjin,
>
> Any comments  on this and other patches. A lot of emails waits for
> your opinion. Is there anything I could do to help you in smooth
> review or applying?

IMO, I think you you should just start collecting fixes and features and
queuing them for Kukjin and then start working as a co-maintainer.

The samsung platforms have been in a near constant state of breakage
over the last *several* cycles, and something really needs to change in
how these are being monitored and maintained.

If someone else is paying closer attention, especially to important
fixes like this and the recent ones for other imprecies aborts etc.,
all of us who are trying to use these Exynos platforms with mainline
will be in much better shape.

Kevin
