From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 20 Feb 2014 09:02:18 +0100
Subject: [PATCH 2/2] clocksource: armada-370-xp: Use atomic access for
 shared registers
In-Reply-To: <5305B5E6.2060906@linaro.org>
References: <1392840326-29417-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1392840326-29417-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <5305B5E6.2060906@linaro.org>
Message-ID: <5305B68A.3050709@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2014 08:59 AM, Daniel Lezcano wrote:
> On 02/19/2014 09:05 PM, Ezequiel Garcia wrote:
>> Replace the driver-specific thread-safe shared register API
>> by the recently introduced atomic_io_clear_set().
>
> Hi Ezequiel,
>
> AFAICS, the code is lockless, your change adds a lock.
>
> What race is it supposed to fix ?

Nevermind, I just noticed it is related to the watchdog driver.



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
