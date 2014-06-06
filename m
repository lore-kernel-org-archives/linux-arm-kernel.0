From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 6 Jun 2014 17:48:21 -0400 (EDT)
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
References: <CAD=FV=UX90hgyojW3k_kpT=mt8eX9=AyHr+AGjhK=MrE1hHbUA@mail.gmail.com>
 <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1406061740280.25775@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 6 Jun 2014, Abhilash Kesavan wrote:

> Hi Doug,
> 
> The first change in the kernel (clearing an iRAM location) is needed
> because of an unnecessary change that we are carrying in the Chrome
> U-boot. There is no reason for us to have the workaround in the
> mainline kernel. Rather, we should remove the check from our u-boot.
> However AFAIR a clean-up patch that I had posted internally was not
> accepted as we had frozen the SPL at the time.
> 
> The second change is to enable snoops for boot cluster. Internally, we
> were disabling the snoops for both the clusters at power off and
> enabling it in power_up_setup and power_up. However, I dropped the
> approach due to problems pointed out by Nicolas here
> http://www.spinics.net/lists/arm-kernel/msg324091.html related to
> cpuidle. Hence, we turn it on at the u-boot.

You should never *ever* play with the CCI from U-Boot.  That's for the 
MCPM layer to decide when it is safe to do so.  That's mainly the 
_whole_ reason why MCPM exists in the first place.


Nicolas
