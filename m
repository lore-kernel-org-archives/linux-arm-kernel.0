From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 16 Oct 2017 14:31:30 -0500
Subject: [GIT PULL] Qualcomm Driver updates for 4.15
In-Reply-To: <1508182291-23352-1-git-send-email-andy.gross@linaro.org>
References: <1508182291-23352-1-git-send-email-andy.gross@linaro.org>
Message-ID: <1508182291-23352-4-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.15

for you to fetch changes up to 8c1b7dc9ba2294c6dbd1870a3d2e534bfda3047a:

  firmware: qcom: scm: Expose download-mode control (2017-10-11 23:48:27 -0500)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v4.15

* Add SCM firmware APIs for download mode and secure IO service
* Add SMEM support for cached entries
* Add SMEM support for global partition, dynamic item limit, and more hosts

----------------------------------------------------------------
Bjorn Andersson (4):
      soc: qcom: smem: Rename "uncached" accessors
      soc: qcom: smem: Support getting cached entries
      firmware: qcom: scm: Expose secure IO service
      firmware: qcom: scm: Expose download-mode control

Chris Lew (5):
      soc: qcom: smem: Use le32_to_cpu for comparison
      soc: qcom: smem: Read version from the smem header
      soc: qcom: smem: Support global partition
      soc: qcom: smem: Support dynamic item limit
      soc: qcom: smem: Increase the number of hosts

 .../devicetree/bindings/firmware/qcom,scm.txt      |   2 +
 drivers/firmware/Kconfig                           |  11 +
 drivers/firmware/qcom_scm-32.c                     |  24 ++
 drivers/firmware/qcom_scm-64.c                     |  44 +++
 drivers/firmware/qcom_scm.c                        |  87 ++++++
 drivers/firmware/qcom_scm.h                        |   8 +
 drivers/soc/qcom/smem.c                            | 335 ++++++++++++++++-----
 include/linux/qcom_scm.h                           |   4 +
 8 files changed, 445 insertions(+), 70 deletions(-)
