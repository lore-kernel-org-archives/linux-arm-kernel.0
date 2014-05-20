From: olof@lixom.net (Olof Johansson)
Date: Tue, 20 May 2014 11:19:14 -0700
Subject: [PATCH v9 10/14] ARM: config: append lpae configuration
In-Reply-To: <1400591427-21922-11-git-send-email-haojian.zhuang@linaro.org>
References: <1400591427-21922-1-git-send-email-haojian.zhuang@linaro.org>
 <1400591427-21922-11-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CAOesGMg8Hkt9dqYgxet4jPQbTO=D0iuRpmJGGk+LXWe-VAonpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 6:10 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:
> Append multi_v7_lpae_config. In this default configuration,
> CONFIG_ARCH_MULTI_V6 is disabled. CONFIG_ARM_LPAE is enabled.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/configs/multi_v7_lpae_defconfig | 351 +++++++++++++++++++++++++++++++
>  1 file changed, 351 insertions(+)
>  create mode 100644 arch/arm/configs/multi_v7_lpae_defconfig

This has to be done with more care than just taking v7_defconfig and
enabling LPAE. There are lots of platforms enabled in this config that
would never boot with LPAE on.


-Olof
