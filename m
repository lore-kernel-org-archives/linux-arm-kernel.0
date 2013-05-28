From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 28 May 2013 15:57:52 -0700
Subject: build failure: linux-next: ARM defconfig: u8500
Message-ID: <CAGa+x87czosA=tWh1KRTSSqMyLckMHwNP7hrRXdokaLsSaaikA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

u8500_defconfig started failing to build in linux next (next-20130527)
but was previously building (next-20130523.)  The build failure looks
like a failed merge attempt:

/work/kernel/next/drivers/pinctrl/pinctrl-abx500.c: In function
'abx500_gpio_probe':
/work/kernel/next/drivers/pinctrl/pinctrl-abx500.c:898:1: error:
expected expression before '<<' token
/work/kernel/next/drivers/pinctrl/pinctrl-abx500.c:900:21: error:
'struct abx500_pinctrl' has no member named 'lock'
/work/kernel/next/drivers/pinctrl/pinctrl-abx500.c:901:1: error:
expected expression before '==' token
/work/kernel/next/drivers/pinctrl/pinctrl-abx500.c:904:1: error:
expected expression before '>>' token
make[3]: *** [drivers/pinctrl/pinctrl-abx500.o] Error 1

Full build log available here:
  https://ci.linaro.org/jenkins/job/khilman-kernel-arm-next/arch=arm,defconfig=u8500_defconfig,label=kernel_cloud/54/console

Kevin
