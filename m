From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 28 Feb 2012 19:21:07 +0200
Subject: [PATCH 0/5] trivial remoteproc/rpmsg fixes
In-Reply-To: <1330449672-18191-1-git-send-email-ohad@wizery.com>
References: <1330449672-18191-1-git-send-email-ohad@wizery.com>
Message-ID: <1330449672-18191-2-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Five trivial remoteproc/rpmsg fixes.

One was reported by Russell (the Kconfig fixes) and one by Omar (the endpoint
leak).

Ohad Ben-Cohen (5):
  remoteproc: make sure we're parsing a 32bit firmware
  remoteproc/omap: two Kconfig fixes
  rpmsg: fix name service endpoint leak
  rpmsg: validate incoming message length before propagating
  rpmsg: fix published buffer length in rpmsg_recv_done

 drivers/remoteproc/Kconfig           |    3 +-
 drivers/remoteproc/remoteproc_core.c |    8 ++++++
 drivers/rpmsg/virtio_rpmsg_bus.c     |   42 ++++++++++++++++++++++++++++-----
 3 files changed, 44 insertions(+), 9 deletions(-)

-- 
1.7.5.4
