From: jun.nie@linaro.org (Jun Nie)
Date: Tue, 22 Mar 2016 10:17:52 +0800
Subject: [PATCH 2/2] serial: amba-pl011: complete support to ZTE uart
In-Reply-To: <56F0A88C.9050209@codeaurora.org>
References: <1457920282-14823-1-git-send-email-jun.nie@linaro.org>
 <1457920282-14823-2-git-send-email-jun.nie@linaro.org>
 <56F05C16.1030805@codeaurora.org>
 <CABymUCNKOgdLBLr2fZ4KhwmG+R4Zm-LHnfDppV-yiwUjRH4Nyg@mail.gmail.com>
 <56F0A628.2080607@codeaurora.org>
 <CABymUCOX5zws9QfXp5Wud2JBAYJZH4rxPRVVgbk7tRvbUUHChA@mail.gmail.com>
 <56F0A88C.9050209@codeaurora.org>
Message-ID: <CABymUCMDqfLsCr7dWxWpKZZwEqr+vO59GR+wUnyJqSGzXQYuDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-03-22 10:06 GMT+08:00 Timur Tabi <timur@codeaurora.org>:
> Jun Nie wrote:
>>
>> That's a fair comment. I suppose all platform need to enable clock for
>> the device. For device tree case, we need these code for clock
>> enabling.
>
>
> But why do you need to enable the clock?  The pl011 driver works fine for
> every platform without your patch.  If the ZTE platform needs to call
> clk_get() in order to work, than that is something different about your
> platform.

ARM/ST pl011 is amba device and use pl011_probe() for initialization,
which call these clock enabling code for every device. You introduced
platform device driver entry for pl011 and only sbsa use platform
device probe method currently. I am trying to reuse this probe
function, so need to add clock enabling code in this function.

If you did not find any issue in sbsa device tree case, I guess the
clock is always enabled. For mobile platform, clock is auto gated for
power saving in most of cases.

>
>> For ACPI case, it may be handled automatically. If you agree
>> my opinion, I will move these lines to patch 1. Please correct me if I
>> am wrong.
>
>
> I think you need to create a separate patch that adds that call, and make
> sure it's tested by other platforms before it gets accepted.

These code only impact sbsa device as only sbsa device is initialized
via platform driver entry. So only your flavor is need for testing the
code. Thanks! :-)

Jun
>
>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the
> Code Aurora Forum, hosted by The Linux Foundation.
