From: dianders@chromium.org (Doug Anderson)
Date: Wed, 22 Oct 2014 17:04:08 -0700
Subject: [PATCH v4 6/6] ARM: dts: add RK3288 suspend support
In-Reply-To: <1413933981-25875-1-git-send-email-zyw@rock-chips.com>
References: <1413933461-25602-1-git-send-email-zyw@rock-chips.com>
 <1413933981-25875-1-git-send-email-zyw@rock-chips.com>
Message-ID: <CAD=FV=VAxmju6L6AEkU4VSuAEKDGmoN6rxE17JsTttWPHKKvBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris,

On Tue, Oct 21, 2014 at 4:26 PM, Chris Zhong <zyw@rock-chips.com> wrote:
> add pmu_intmem node for suspend, add global_pwroff pinctrl.
> The pmu_intmem is used to store the resume code.
> global_pwroff is held low level at work, it would be pull to high
> when entering suspend. PMICs can get this signal, then shut down
> some power rails. So please reference the global_pwroff pinctrl
> as part of the PMIC config.

nit: I would just say to reference this in the board DTS file since
some boards need it.  You could imagine this being useful to something
other than a PMIC.


> +       pmu_intmem at ff720000 {
> +               compatible = "rockchip,rk3288-pmu-sram", "mmio-sram";
> +               reg = <0xff720000 0x4000>;

My TRM says this is 4K big.  You're specifying 16K here.  If it's
really 4K, it should be <0xff720000 0x1000>
