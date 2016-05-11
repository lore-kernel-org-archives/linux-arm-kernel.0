From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 May 2016 07:49:19 +0200
Subject: [PATCH] ARM: dts: exynos: Only Odroid XU3-family boards use DTSI
 with CPU thermal nodes
In-Reply-To: <CANAwSgQGhrBca7=Ow8+Hh9t0W9HWp=F43KR0Frfpx9fGngPSaw@mail.gmail.com>
References: <1462774789-15360-1-git-send-email-k.kozlowski@samsung.com>
 <CANAwSgT9SY3kj8+beMpc1xGoC=rMBSya+2v2dyZQp6ykH+V0=g@mail.gmail.com>
 <573198BE.6020900@samsung.com>
 <CANAwSgTy6p9AVmmOWATpSO1JqVbwE0v+y_y-RLd+32RnNJTA+Q@mail.gmail.com>
 <5731D764.8070007@samsung.com>
 <CANAwSgRsjdQh6ygT__5XcH8-cF9Ch+zbk8oupebwYzY1kCZu6g@mail.gmail.com>
 <5731EA1B.4070201@samsung.com>
 <CANAwSgQGhrBca7=Ow8+Hh9t0W9HWp=F43KR0Frfpx9fGngPSaw@mail.gmail.com>
Message-ID: <5732C7DF.2080800@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2016 09:45 PM, Anand Moon wrote:
> Hi Krzysztof,
> 
> Sorry I am not able to explain my self clearly.
> But I have once gain tested these changes.
> 
> Only could you append with following changes.
> --------------------------------------------------------
> +                               cpu_crit0: cpu-crit-0 {
> +                                       temperature = <120000>; /*
> millicelsius */
> +                                       hysteresis = <5000>; /* millicelsius */
> +                                       type = "critical";
> +                               };
> --------------------------------------------------------
> hysteresis time help to adjust the present and past temperature inputs
> before critical shutdown.

I need more details why you want this patch. What is the point of
hysteresis on critical trip point? When reaching this trip point the
system shutdowns... there is nothing more to do, I think.

Best regards,
Krzysztof
