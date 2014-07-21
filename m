From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 21 Jul 2014 16:45:02 +0200
Subject: [PATCH] clocksource: sirf: fix incorrect clock enable counter
 for timer
In-Reply-To: <1404391971-24214-1-git-send-email-21cnbao@gmail.com>
References: <1404391971-24214-1-git-send-email-21cnbao@gmail.com>
Message-ID: <53CD276E.9020804@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/2014 02:52 PM, Barry Song wrote:
> From: Zhiwu Song <Zhiwu.Song@csr.com>
>
> in the clocksource driver, we didn't explicitly enable the clock.
> it makes the clk reference counter wrong.
> we didn't encounter any hang issue because the tick's clock input
> has been open and is shared by some other hardware components, but
> if we don't enable those components in kernel, in the stage of
> disabling unused clk in kernel boot, Linux tick hangs.
>
> this patch fixes it. it does an explicit prepare and enable to the
> clock input, and increases the usage counter of the clk.
>
> Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>


Applied to my tree for 3.17

Thanks!

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
