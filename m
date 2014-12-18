From: john.stultz@linaro.org (John Stultz)
Date: Thu, 18 Dec 2014 13:21:54 -0800
Subject: [PATCH] optimize ktime_divns for constant divisors
In-Reply-To: <2110446.Lbe6oKjkNj@wuerfel>
References: <alpine.LFD.2.11.1412031424150.470@knanqh.ubzr>
 <alpine.LFD.2.11.1412051251280.470@knanqh.ubzr>
 <2110446.Lbe6oKjkNj@wuerfel>
Message-ID: <CALAqxLVzOAeOj8Rdo9=owEQ8Jy=-J1jQbaPoqxZqYJBdbwFTwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 5, 2014 at 1:03 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 05 December 2014 13:00:22 Nicolas Pitre wrote:
>>
>> BTW this is worth applying despite the on-going discussion with Arnd
>> on a separate optimization.
>
> Agreed
>
>> On Wed, 3 Dec 2014, Nicolas Pitre wrote:
>>
>> > At least on ARM, do_div() is optimized to turn constant divisors into
>> > an inline multiplication by the reciprocal value at compile time.
>> > However this optimization is missed entirely whenever ktime_divns() is
>> > used and the slow out-of-line division code is used all the time.
>> >
>> > Let ktime_divns() use do_div() inline whenever the divisor is constant
>> > and small enough.  This will make things like ktime_to_us() and
>> > ktime_to_ms() much faster.
>> >
>> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>


Ok, I've queued the original patch up for testing.

thanks
-john
