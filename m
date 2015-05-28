From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 28 May 2015 10:55:39 -0500 (CDT)
Subject: [GIT PULL] qcom SoC changes for 4.2-1
In-Reply-To: <alpine.DEB.2.02.1505261449220.26936@galak-ubuntu.qualcomm.com>
References: <alpine.DEB.2.02.1505261449220.26936@galak-ubuntu.qualcomm.com>
Message-ID: <alpine.DEB.2.02.1505281055020.17861@galak-ubuntu.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Updated to pull in one long standing SCM change to add HDCP support)

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-soc-for-4.2-1

for you to fetch changes up to 9626b6993b2e6faf047d2d96958e8474edc9c7a5:

   firmware: qcom: scm: Add HDCP Support (2015-05-28 10:47:45 -0500)

----------------------------------------------------------------
Qualcomm ARM Based SoC Updates for v4.2-1

* Added Subsystem Power Manager (SPM) driver
* Split out 32-bit specific SCM code
* Added HDCP SCM call

----------------------------------------------------------------
Kumar Gala (1):
       firmware: qcom: scm: Split out 32-bit specific SCM code

Lina Iyer (1):
       ARM: qcom: Add Subsystem Power Manager (SPM) driver

jilai wang (1):
       firmware: qcom: scm: Add HDCP Support

  drivers/firmware/Makefile      |   3 +-
  drivers/firmware/qcom_scm-32.c | 503 +++++++++++++++++++++++++++++++++++++++++
  drivers/firmware/qcom_scm.c    | 474 ++++----------------------------------
  drivers/firmware/qcom_scm.h    |  47 ++++
  drivers/soc/qcom/Kconfig       |   7 +
  drivers/soc/qcom/Makefile      |   1 +
  drivers/soc/qcom/spm.c         | 385 +++++++++++++++++++++++++++++++
  include/linux/qcom_scm.h       |  13 +-
  8 files changed, 995 insertions(+), 438 deletions(-)
  create mode 100644 drivers/firmware/qcom_scm-32.c
  create mode 100644 drivers/firmware/qcom_scm.h
  create mode 100644 drivers/soc/qcom/spm.c

--
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
