From: olof@lixom.net (Olof Johansson)
Date: Mon, 9 Nov 2015 19:38:12 -0800
Subject: [RFC PATCH] ARM: add v7 LPAE multi-platform defconfig
In-Reply-To: <1447124035-18585-1-git-send-email-b18965@freescale.com>
References: <1447124035-18585-1-git-send-email-b18965@freescale.com>
Message-ID: <CAOesGMgvfdMj_GB3w_dvxxPkgBZUpo=kQ+60a89yY__-QT2eBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alison,

On Mon, Nov 9, 2015 at 6:53 PM, Alison Wang <b18965@freescale.com> wrote:
> v7 LPAE multi-platform defconfig is based on v7 multi-platform
> defconfig and adds LPAE support.
>
> The platforms based on Cortex-A7/A12/A15/A17, PJ4B, Krait are
> also enabled in this defconfig. But Cortex-A5/A8/A9, Scorpion
> and PJ4 are removed.
>
> This defconfig is verified on LS1021A which enables GIANFAR,
> I2C, WATCHDOG, AUDIO, EDMA and DSPI drivers, etc.
>
> The other platforms need to be verified by the platform
> maintainers too.
>
> Signed-off-by: Alison Wang <alison.wang@freescale.com>

This has been discussed before, and what we have chosen to do is to
just have a multi_v7_defconfig that all these platforms are enabled on
but with LPAE off.

Instead, what we do when building (and on our build/boot builders) is
to take multi_v7 and provide the snippet that turns on ARM_LPAE at
that time.


Regards,

-Olof
