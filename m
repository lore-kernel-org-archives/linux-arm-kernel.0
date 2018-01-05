From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Jan 2018 18:06:26 +0100
Subject: [GIT PULL 5/5] i.MX defconfig updates for 4.16
In-Reply-To: <1514959040-9992-5-git-send-email-shawnguo@kernel.org>
References: <1514959040-9992-1-git-send-email-shawnguo@kernel.org>
 <1514959040-9992-5-git-send-email-shawnguo@kernel.org>
Message-ID: <CAK8P3a2bWz5n+Scy_pvaHo0AJ5w0cuY1Fyiidc0Ygk0=7AF5-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 3, 2018 at 6:57 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> The following changes since commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36:
>
>   Linux 4.15-rc3 (2017-12-10 17:56:26 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.16
>
> for you to fetch changes up to 189114b47b1cfcc5da02db9bcafebd2042aa7ab8:
>
>   ARM: imx_v6_v7_defconfig: enable CONFIG_CPU_FREQ_STAT (2017-12-26 17:04:13 +0800)
>
> ----------------------------------------------------------------
> i.MX defconfig updates for 4.16:
>  - Enable CPU_FREQ_STAT for cpufreq transtion statistics support.
>  - Enable SRTC driver RTC_DRV_MXC_V2 for i.MX53.
>  - Turn on a few drivers useful for DART-MX6 SoM support, SERDEV
>    bluetooth, SERIAL_DEV_BUS, WL18XX, and DEFAULT_ON LED Trigger.
>
> ----------------------------------------------------------------
> Dong Aisheng (1):
>       ARM: imx_v6_v7_defconfig: enable CONFIG_CPU_FREQ_STAT

This commit looks a bit fishy, as it does multiple things:

- add multitouch support
- move options around in the file that did not change
- drop some options (AEABI, CMA, SOC_CAMERA_OV2640,
   SERIAL_DEV_CTRL_TTYPORT) for unknown reasons.

Cleaning up is fine, but please don't mix that with functional changes.
It's also fine to add multiple options at once in one patch, but when
you use 'make savedefconfig', please check each option that
gets dropped, some options might have gained new dependencies
or got renamed but are still needed here.

Finally, it might be good to check if the newly added options should
also be added to multi_v7_defconfig.

Not pulled for now, I'd suggest you resend without the 'savedefconfig'
cleanup, we can do that in a follow-up.

      Arnd
