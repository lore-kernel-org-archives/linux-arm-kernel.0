From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 13 Jul 2017 15:21:21 +0530
Subject: [RFC v2 5/6] drivers: boot_constraint: Add initial DT bindings
In-Reply-To: <CAGb2v67pjFRTq56DE+2xCnnKhxa_1u6RdoxbwXznkg6EJ3=X9Q@mail.gmail.com>
References: <cover.1499770771.git.viresh.kumar@linaro.org>
 <0610277aef9830cff53b7b53cf41cc54886fdc7f.1499770771.git.viresh.kumar@linaro.org>
 <CAL_Jsq+oAB3gejRMXuY0q9+Et4GrtvF3RwGzPNJ08TPooVyXJg@mail.gmail.com>
 <CAGb2v67XtUcqdjMt-Ln6zn3ShH4JFmjkK4bPSpUNZpJqnmwivw@mail.gmail.com>
 <20170713050934.GB352@vireshk-i7>
 <CAGb2v67pjFRTq56DE+2xCnnKhxa_1u6RdoxbwXznkg6EJ3=X9Q@mail.gmail.com>
Message-ID: <20170713095121.GH352@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-07-17, 17:46, Chen-Yu Tsai wrote:
> This makes more sense. The LCD being able to do DVFS was missing from the last
> discussion. I assume this is for power saving purposes?

Yeah.

> Otherwise one could just
> say you should not use the lower part of the voltage range. And DVFS is for the
> controller's core logic and not I/O?

Yeah.

But for many such cases in different platforms, the LCD controller may
not do DVFS. But we still need to make sure its clk, regulator and
power domain are enabled until the time the driver comes up. This
series would also help in doing proxy-voting for all such resources,
so that they don't get disabled while being used.

-- 
viresh
