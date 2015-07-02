From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 02 Jul 2015 10:07:11 +0200
Subject: [RFC] arm: psci: implement cpuidle_ops
In-Reply-To: <20150702111031.05f04184@xhacker>
References: <20150702111031.05f04184@xhacker>
Message-ID: <5594F12F.6050401@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/2015 05:10 AM, Jisheng Zhang wrote:
> Hi all,
>
> we'd like to use cpuidle-arm.c for both arm and arm64 with psci as backend. For
> arm64, it works. But for arm, we miss cpuidle_ops. I want to add cpuidle_ops for
> arm psci, I dunno whether this is the correct direction, could you please give
> suggestions?

You should look at the macro

arch/arm/include/asm/cpuidle.h:

#define CPUIDLE_METHOD_OF_DECLARE(name, _method, _ops)


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
