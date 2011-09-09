From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 8 Sep 2011 22:29:34 -0300
Subject: [PATCH] ARM: imx: move pwm driver to use platform device id table
In-Reply-To: <CAMPhdO-k7yJxnqYdB+N4ZbyTxoASnwaXrWxHzyAR8sB+sJMjQg@mail.gmail.com>
References: <1315524142-10566-1-git-send-email-eric.miao@linaro.org>
	<CAOMZO5AybMLPK2Q8RrE9cAemHjGgsz-+Z0-VCtOB5t=rxFrN4w@mail.gmail.com>
	<CAMPhdO-k7yJxnqYdB+N4ZbyTxoASnwaXrWxHzyAR8sB+sJMjQg@mail.gmail.com>
Message-ID: <CAOMZO5AyQQu3z063yHyDrG3qg_cSMtDWVF0btFw+ZwcUHdmGkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2011 at 9:49 PM, Eric Miao <eric.miao@linaro.org> wrote:
> On Thu, Sep 8, 2011 at 5:42 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> On Thu, Sep 8, 2011 at 8:22 PM, Eric Miao <eric.miao@linaro.org> wrote:
>>> Signed-off-by: Eric Miao <eric.miao@linaro.org>
>>> ---
>>> ?arch/arm/mach-imx/clock-imx25.c ? ? ? ? ? ? ?| ? ?8 ++++----
>>> ?arch/arm/mach-imx/clock-imx27.c ? ? ? ? ? ? ?| ? ?2 +-
>>> ?arch/arm/mach-imx/devices-imx25.h ? ? ? ? ? ?| ? ?2 +-
>>> ?arch/arm/mach-mx5/clock-mx51-mx53.c ? ? ? ? ?| ? ?4 ++--
>>> ?arch/arm/mach-mx5/devices-imx51.h ? ? ? ? ? ?| ? ?2 +-
>>> ?arch/arm/plat-mxc/devices/platform-mxc_pwm.c | ? ?4 ++--
>>> ?arch/arm/plat-mxc/pwm.c ? ? ? ? ? ? ? ? ? ? ?| ? 19 ++++++++++++++++---
>>> ?7 files changed, 27 insertions(+), 14 deletions(-)
>>
>> Looks like you missed mx1, mx21, mx31, mx27, mx35 and mx53.
>
> Did a search of 'mxc_pwm' string, but they didn't seem to be there?
> which is a bit strange.

The PWM clock are currently registered differently for each SoC:

On MX21: _REGISTER_CLOCK(NULL, "pwm", pwm_clk[0])
On MX25: _REGISTER_CLOCK("mxc_pwm.0", NULL, pwm1_clk)
On MX27: _REGISTER_CLOCK("mxc_pwm.0", NULL, pwm_clk)
On MX31: _REGISTER_CLOCK(NULL, "pwm", pwm_clk)
On MX35: _REGISTER_CLOCK(NULL, "pwm", pwm_clk)
On MX51:  _REGISTER_CLOCK("mxc_pwm.0", "pwm", pwm1_clk)
