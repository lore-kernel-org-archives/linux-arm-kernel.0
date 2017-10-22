From: andy.gross@linaro.org (Andy Gross)
Date: Sun, 22 Oct 2017 05:19:58 -0500
Subject: [GIT PULL] Qualcomm Driver updates for 4.15 Part 2
Message-ID: <1508667598-5069-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8c1b7dc9ba2294c6dbd1870a3d2e534bfda3047a:

  firmware: qcom: scm: Expose download-mode control (2017-10-11 23:48:27 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.15-2

for you to fetch changes up to d1de6d6c639b7827c42c4750b8101ed1049e1c72:

  soc: qcom: Remote filesystem memory driver (2017-10-22 05:06:34 -0500)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v4.15 Part 2

* Add Qualcomm Remote Filesystem Memory driver
* Add OF linkage for RMTFS

----------------------------------------------------------------
Bjorn Andersson (4):
      of/platform: Generalize /reserved-memory handling
      of: reserved_mem: Accessor for acquiring reserved_mem
      dt-binding: soc: qcom: Add binding for rmtfs memory
      soc: qcom: Remote filesystem memory driver

 .../bindings/reserved-memory/qcom,rmtfs-mem.txt    |  51 ++++
 drivers/of/of_reserved_mem.c                       |  26 ++
 drivers/of/platform.c                              |  19 +-
 drivers/soc/qcom/Kconfig                           |  11 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/rmtfs_mem.c                       | 271 +++++++++++++++++++++
 include/linux/of_reserved_mem.h                    |   5 +
 7 files changed, 376 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt
 create mode 100644 drivers/soc/qcom/rmtfs_mem.c
