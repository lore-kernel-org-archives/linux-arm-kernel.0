From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 26 Oct 2015 09:56:50 +0900
Subject: [PATCH v5 4/5] ARM: dts: mt8135: enable basic SMP bringup for
 mt8135
In-Reply-To: <1443799181-50409-5-git-send-email-yingjoe.chen@mediatek.com>
References: <1443799181-50409-1-git-send-email-yingjoe.chen@mediatek.com>
 <1443799181-50409-5-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <CAMAWPa-Ed2FJY2pW67EHHKBH3_eBZx0+oWfMJwc_DhEjrf7aMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, Oct 3, 2015 at 12:19 AM, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
> Add arch timer node to enable arch-timer support. MT8135 firmware
> doesn't correctly setup arch-timer frequency and CNTVOFF, add
> properties to workaround this.
>
> This also set cpu enable-method to enable SMP.
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>

kernelci.org started detecting new boot failures for the mt8135-evb in
the arm-soc tree[1], and the boot failures were bisected down to this
patch, which landed upstream in the form of commit d186a394bb98 (ARM:
dts: mt8135: enable basic SMP bringup for mt8135)

Maybe this new SMP support requires updating the firmware on the board
as well?  If so, the changelog should've been a bit more explicit
about firmware dependencies.

Kevin

[1] http://kernelci.org/boot/mt8135-evbp1/job/arm-soc/kernel/v4.3-rc5-795-ga4b616012d2e/defconfig/multi_v7_defconfig/lab/lab-khilman/?_id=562b1cf959b5149e07111471
