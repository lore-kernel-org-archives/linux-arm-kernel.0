From: nicolas.dechesne@linaro.org (Nicolas Dechesne)
Date: Thu, 9 Oct 2014 08:56:35 +0200
Subject: [PATCH v2 3/3] ARM: dts: qcom: Add SDHC nodes for APQ8084 platform
In-Reply-To: <20141008194541.GV868@joshc.qualcomm.com>
References: <1409672443-4289-1-git-send-email-gdjakov@mm-sol.com>
 <1409672443-4289-4-git-send-email-gdjakov@mm-sol.com>
 <CAP71WjxYibPGBC=x4eA-Lmjg_Mc7cCB20VSvf59C_AW7PYNE=A@mail.gmail.com>
 <20141008194541.GV868@joshc.qualcomm.com>
Message-ID: <CAP71WjxueWji84Ki8eXoTxfW=cyJCB38ivyv-_PXTv7QHPHxDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 8, 2014 at 9:45 PM, Josh Cartwright <joshc@codeaurora.org> wrote:
> This has bitten me more times than I care to admit, but have you checked
> that you've set CONFIG_MMC_BLOCK_MINORS higher than 16?  Perhaps we
> should be doing that in qcom_defconfig if we aren't already.

ouch... i was using multi_v7_defconfig which indeed has:

CONFIG_MMC_BLOCK_MINORS=16

note that you can override the default CONFIG with bootargs with

mmcblk.perdev_minors=32

thanks!
