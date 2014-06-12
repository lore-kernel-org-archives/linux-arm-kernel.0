From: tushar.b@samsung.com (Tushar Behera)
Date: Thu, 12 Jun 2014 13:00:53 +0530
Subject: [PATCH 1/3] clk: exynos-audss: Keep the parent of mout_audss
 always enabled
In-Reply-To: <539891D0.8090309@gmail.com>
References: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>
 <1402464739-19044-2-git-send-email-tushar.b@samsung.com>
 <539891D0.8090309@gmail.com>
Message-ID: <CAC5m3BwYTSBW9WxH+f002aU1mMQH-0_WbGUiPgsabOh8C-YV+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 10:58 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Tushar,
>
> On 11.06.2014 07:32, Tushar Behera wrote:
>> When the output clock of AUDSS mux is disabled, we are getting kernel
>> oops while doing a clk_get() on other clocks provided by AUDSS. Though
>> user manual doesn't specify this dependency, we came across this issue
>> while disabling the parent of AUDSS mux clocks.
>
> Could you provide more data about this oops? E.g. kernel log, platforms
> it affects (just peach-pit or also others), test case, extra patches
> applied on top of mainline (if any).
>
> I don't like this solution, because keeping a clock always enabled is
> usually not desirable and this driver is also used on other platforms
> than peach-pit, so this change will affect all of them.
>

I will update later after doing similar tests on other platforms.

> Best regards,
> Tomasz
