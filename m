From: abrestic@chromium.org (Andrew Bresticker)
Date: Fri, 11 Jul 2014 09:33:47 -0700
Subject: [PATCH 12/13] cpufreq: Add cpufreq driver for Tegra124
In-Reply-To: <53C002BE.90805@nvidia.com>
References: <1405028569-14253-1-git-send-email-ttynkkynen@nvidia.com>
 <1405028569-14253-13-git-send-email-ttynkkynen@nvidia.com>
 <CAKohpom9ORXFiUU4=V+CxgN0ZOFLMEhEjHiU8HsYUYDybNXgHQ@mail.gmail.com>
 <20140711091207.GY23218@tbergstrom-lnx.Nvidia.com>
 <20140711145735.GB6523@ulmo> <53BFFEAD.7000405@nvidia.com>
 <20140711151501.GA25810@ulmo> <53C002BE.90805@nvidia.com>
Message-ID: <CAL1qeaGOW8U6B0rLvFZKLzoZviMZwWJcfmXdmgZA329Mmvy_Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 8:29 AM, Tuomas Tynkkynen <ttynkkynen@nvidia.com> wrote:
>
> On the hardware level, the two I2C controllers sharing the same pins
> have knowledge of each other and won't start transmitting if the bus
> is busy (something different from the usual I2C arbitration, that is).
> I guess on the kernel side there could be a problem if the voltage register
> is marked cached in the PMIC driver's regmap.

Yeah, in our tree we have a hack to disable regcache for SD0_VOLTAGE.
Other than the value reported to userspace being wrong, leaving it as
cacheable shouldn't be an issue if no other drivers try to read/write
that register.
