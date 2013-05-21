From: robherring2@gmail.com (Rob Herring)
Date: Tue, 21 May 2013 11:42:12 -0500
Subject: spurious bL cpufreq driver messages
In-Reply-To: <CAKohpomG5E2FAeZGnX3eBw8fOiX3K8sWEeHgb5NT_FT3y+Cg1w@mail.gmail.com>
References: <519686BC.3090101@gmail.com>
 <CAKohpom0cGfWvsCf-jaMyu0cQJi2hVk9_0wskEDH2X7MaeHDLw@mail.gmail.com>
 <CAL_JsqLEv38DwnL4=ToXtEKNrDbgYv_0qiOc+cXZSjnfKVbeNg@mail.gmail.com>
 <CAKohpomG5E2FAeZGnX3eBw8fOiX3K8sWEeHgb5NT_FT3y+Cg1w@mail.gmail.com>
Message-ID: <CAL_JsqKrZzV+kpQ9rUUkhEAV=kiouAWEuuZnKqX63X6ZPsu3cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 19, 2013 at 11:36 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 19 May 2013 01:21, Rob Herring <robherring2@gmail.com> wrote:
>> No, it still registers the bL driver. The problem is not that DT data
>> is missing, but it is present on a single cluster system.
>
> I misread your mail.. I got the problem now.. Below should fix your
> issue (It is rebased on the patch I pointed to you earlier):
>
> Attached too for testing as gmail copy-paste will break it.
>
> @Rafael: Once Rob gives his Tested-by, please queue it for 3.10-rcs
>
> ------------x-----------------x-----------------
>
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Mon, 20 May 2013 09:57:17 +0530
> Subject: [PATCH] cpufreq: arm_big_little_dt: Instantiate as platform_driver
>
> As multiplatform build is being adopted by more and more ARM platforms, initcall
> function should be used very carefully. For example, when both arm_big_little_dt
> and cpufreq-cpu0 drivers are compiled in, arm_big_little_dt driver may try to
> register even if we had platform device for cpufreq-cpu0 registered.
>
> To eliminate this undesired the effect, the patch changes arm_big_little_dt
> driver to have it instantiated as a platform_driver. Then it will only run on
> platforms that create the platform_device "arm-bL-cpufreq-dt".
>
> Reported-by: Rob Herring <robherring2@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

That works. Thanks.

Tested-by: Rob Herring <rob.herring@calxeda.com>
