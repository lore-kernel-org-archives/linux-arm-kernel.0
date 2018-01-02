From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 2 Jan 2018 11:38:35 +0000
Subject: [GIT PULL] Qualcomm Driver updates for 4.16
In-Reply-To: <1514789609-4133-4-git-send-email-andy.gross@linaro.org>
References: <1514789609-4133-1-git-send-email-andy.gross@linaro.org>
 <1514789609-4133-4-git-send-email-andy.gross@linaro.org>
Message-ID: <003c9462-aea5-f4b5-c5ca-fa0d0504a92b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Andy,

On 01/01/18 06:53, Andy Gross wrote:
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
> 
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.16
> 
> for you to fetch changes up to c01fc2275e01a91e2243d9202c04f3ed872f9de8:
> 
>   soc: qcom: smp2p: Use common error handling code in qcom_smp2p_probe() (2018-01-01 00:29:09 -0600)
> 
> ----------------------------------------------------------------
> Qualcomm ARM Based Driver Updates for v4.16
> 
> * Fix error handling code in SMP2P probe
> * Update SMP2P to use ACPS as mailbox client
> * Add QMI support
> * Fixups for Qualcomm SCM
> * Fix licensing on rmtfs_mem
> * Correct SMSM child node lookup
> 
> ----------------------------------------------------------------
> Bjorn Andersson (3):
>       soc: qcom: smp2p: Access APCS as mailbox client
>       soc: qcom: Introduce QMI encoder/decoder
>       soc: qcom: Introduce QMI helpers
> 
> Jesse Chan (1):
>       soc: qcom: rmtfs_mem: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
> 
> Johan Hovold (1):
>       soc: qcom: smsm: fix child-node lookup
> 
> Jordan Crouse (1):
>       firmware: qcom_scm: Add dependent headers to qcom_scm.h
> 
> Markus Elfring (1):
>       soc: qcom: smp2p: Use common error handling code in qcom_smp2p_probe()
> 
> Sudeep Holla (1):
>       firmware: qcom_scm: drop redandant of_platform_populate
> 

As Bjorn mention on the actual thread, you also need

"[PATCH 1/4] of: platform: populate /firmware/ node from
of_platform_default_populate_init()"

which Rob has acked and I am fine if you pick it along with the above patch.

>  .../devicetree/bindings/soc/qcom/qcom,smp2p.txt    |   8 +-
>  drivers/firmware/qcom_scm.c                        |  24 -
>  drivers/soc/qcom/Kconfig                           |  10 +
>  drivers/soc/qcom/Makefile                          |   2 +
>  drivers/soc/qcom/qmi_encdec.c                      | 816 ++++++++++++++++++++
>  drivers/soc/qcom/qmi_interface.c                   | 848 +++++++++++++++++++++
>  drivers/soc/qcom/rmtfs_mem.c                       |   4 +
>  drivers/soc/qcom/smp2p.c                           |  55 +-
>  drivers/soc/qcom/smsm.c                            |   6 +-
>  include/linux/qcom_scm.h                           |   3 +
>  include/linux/soc/qcom/qmi.h                       | 271 +++++++
>  11 files changed, 2006 insertions(+), 41 deletions(-)
>  create mode 100644 drivers/soc/qcom/qmi_encdec.c
>  create mode 100644 drivers/soc/qcom/qmi_interface.c
>  create mode 100644 include/linux/soc/qcom/qmi.h
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Regards,
Sudeep
