From: viresh.kumar@linaro.org (viresh kumar)
Date: Thu, 14 Nov 2013 13:39:43 +0530
Subject: a bug on NO_HZ_FULL_ALL
In-Reply-To: <CAKfTPtD7fo08mjQoLXMMDpyxQuyoCZLS33qBnnUcQEmzYai2VQ@mail.gmail.com>
References: <CANHzE=2EOJmjFqLUDSfxTvgQhrUogOxH8Qux9hBFTGf8HiWWEw@mail.gmail.com>	<52843855.5060509@linaro.org>	<52847FBE.9070501@linaro.org>
 <CAKfTPtD7fo08mjQoLXMMDpyxQuyoCZLS33qBnnUcQEmzYai2VQ@mail.gmail.com>
Message-ID: <52848547.9080604@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 November 2013 01:35 PM, Vincent Guittot wrote:
> AFAICT, It's a none issue. In full nohz, a timer fires periodically
> (around 4sec period on ARM IIRC) on one cpu (cpu0).

Timer should always be running on CPU0, its out of nohz-full domain. Its
cpu 1, where it will fire after long delays..


https://wiki.linaro.org/WorkingGroups/PowerManagement/Doc/AdaptiveTickless
