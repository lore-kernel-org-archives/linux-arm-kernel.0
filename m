From: wens213@gmail.com (wens Tsai)
Date: Tue, 17 Mar 2015 15:45:39 +0800
Subject: Is cpufreq-dt safe without regulator support?
Message-ID: <CAGb2v679W_NqG2d597tV9W-5ROZRTH-K542fofA_UbREDjfBhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

The sunxi platform added cpufreq support in 4.0.0-rc1 using
the generic cpufreq-dt driver. One issue we've run into is
the default OPPs we use include an overclocked/overvoltage
setting.

If the cpu is missing a regulator supply phandle, or the
kernel is built without regulators, cpufreq can increase
the clock rate without the needed voltage increase.

The former issue can be resolved by providing a dummy
regulator with the default voltage, effectively disabling
cpufreq.

The latter is possible. Without regulator support built-in,
even a correct, complete DTS can still fail. Should I just
remove the offending OPP? Still that does not fix the
problem when we actually do want overclocking.

To summarize, should cpufreq-dt probe fail when regulator
support isn't available? Should we differentiate between
not having a regulator phandle vs no regulator support?


Regards,
ChenYu
