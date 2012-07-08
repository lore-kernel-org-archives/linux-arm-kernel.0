From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 8 Jul 2012 22:23:32 +0300
Subject: [GIT PULL] rpmsg fixes for 3.5
Message-ID: <CAK=WgbbvHobMODDaa+k10uWfbMaH-6SZ6o9f6Vx+aB2TSvfDQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:

  Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/rpmsg.git
tags/rpmsg-3.5-fixes

for you to fetch changes up to 15fd943af50dbc5f7f4de33835795c72595f7bf4:

  rpmsg: make sure inflight messages don't invoke just-removed
callbacks (2012-07-04 11:51:59 +0300)

----------------------------------------------------------------
Fixing two (somewhat rare) endpoint-related race issues, both of which
were reported by Fernando Guzman Lugo.

----------------------------------------------------------------
Ohad Ben-Cohen (2):
      rpmsg: avoid premature deallocation of endpoints
      rpmsg: make sure inflight messages don't invoke just-removed callbacks

 drivers/rpmsg/virtio_rpmsg_bus.c | 55 ++++++++++++++++++++++++++++++++++++----
 include/linux/rpmsg.h            |  6 +++++
 2 files changed, 56 insertions(+), 5 deletions(-)
