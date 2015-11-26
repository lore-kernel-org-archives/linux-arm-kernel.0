From: sbranden@broadcom.com (Scott Branden)
Date: Thu, 26 Nov 2015 11:59:54 -0800
Subject: [PATCH 0/1] kconfig: add CPU endian selection beconfig and leconfig
Message-ID: <1448567995-8784-1-git-send-email-sbranden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The proposed patch allows a defconfig to be changed to big or little endian
by adding "make beconfig" and "make leconfig" functionality.

This follows on from a discussion with existing arm64 builds and lack of
ability to build for a big endian defconfig as such defconfig is not in
the upstream kernel.

Discussion started on the arm mailing list:
http://www.spinics.net/lists/arm-kernel/msg462636.html

The same problem applies to various architecture families so it makes
sense to apply at a higher level as proposed.

This patchset is based on v4.4-rc1 and is available from github:

repo: https://github.com/Broadcom/arm64-linux.git

branch: kconfig-endian-v1

Scott Branden (1):
  kconfig: add CPU endian selection beconfig and leconfig

 kernel/configs/be.config |  1 +
 kernel/configs/le.config |  1 +
 scripts/kconfig/Makefile | 10 ++++++++++
 3 files changed, 12 insertions(+)
 create mode 100644 kernel/configs/be.config
 create mode 100644 kernel/configs/le.config

-- 
2.5.0
