From: tushar.behera@linaro.org (Tushar Behera)
Date: Mon, 17 Jun 2013 08:41:14 +0530
Subject: [PATCH] ARM: dts: Enable RTC node for exynos5250
In-Reply-To: <CAD=FV=WeY5r_=qLV6dh8HkaNGygZ33uQg5Q6dKhwd31e7MfFTg@mail.gmail.com>
References: <1371189378-22823-1-git-send-email-tushar.behera@linaro.org>
 <CAD=FV=WeY5r_=qLV6dh8HkaNGygZ33uQg5Q6dKhwd31e7MfFTg@mail.gmail.com>
Message-ID: <CAHbNUh2byimQ_ep0j9XkUjRFaU3K6YZE_ANcch5UhP4QsuZxPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 June 2013 20:31, Doug Anderson <dianders@chromium.org> wrote:
> Tushar,
>
> On Thu, Jun 13, 2013 at 10:56 PM, Tushar Behera
> <tushar.behera@linaro.org> wrote:
>> The kernel dump produced by s3c-rtc driver as reported by
>> commit 522ccdb6fd0e ("ARM: dts: Disable the RTC by default on exynos5")
>> are no longer reproducible in latest kernel.
>>
>> Hence it would be good to re-enable RTC support for EXYNOS5250.
>>
>> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
>> ---
>>  arch/arm/boot/dts/exynos5250.dtsi |    1 -
>>  1 file changed, 1 deletion(-)
>
> I would prefer we not commit this.
>
> The original commit wasn't just about avoiding the bug (though that

I thought the intention of the original commit was just that. :-)

> was a nice side effect).  My understanding is that the SoC dtsi file
> ought to have most peripherals disabled by default and individual
> board dts files should enable the peripherals that they want.  I think
> exynos5250 is particularly bad about this right now (it starts with
> most peripherals enabled) but that should probably be fixed...
>

I agree, all the peripherals should be fixed for this, not just RTC.

> If my understanding is wrong, others on the list should definitely speak up!  :)
>

Let me know if you still prefer to keep RTC node disabled on exynos5250.dtsi.
In that case, I would enable it only for Arndale.

> -Doug


Thanks.
--
Tushar Behera
