From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 6 Jul 2017 21:52:30 +0530
Subject: [GIT PULL] Mailbox changes for v4.13
Message-ID: <CABb+yY2v=RrVk5E9eWAX5j2sMO=4waawGdQCHMQU8S-4GgBm+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 63f700aab4c11d46626de3cd051dae56cf7e9056:

  Merge tag 'xtensa-20170612' of
git://github.com/jcmvbkbc/linux-xtensa (2017-06-13 15:09:10 +0900)

are available in the git repository at:

  https://git.linaro.org/landing-teams/working/fujitsu/integration.git
mailbox-for-next

for you to fetch changes up to 25bfee16d5a3158086273cc51110c7470144c842:

  mailbox: Introduce Qualcomm APCS IPC driver (2017-06-14 17:47:19 +0530)

----------------------------------------------------------------
- Minor improvement : avoid requiring unnecessary startup/shutdown
callback that many drivers seem to not need
- New controller driver for Qualcomm's APCS IPC

----------------------------------------------------------------
Bjorn Andersson (3):
      mailbox: Make startup and shutdown ops optional
      dt-bindings: mailbox: Introduce Qualcomm APCS global binding
      mailbox: Introduce Qualcomm APCS IPC driver

 .../bindings/mailbox/qcom,apcs-kpss-global.txt     |  46 ++++++++
 drivers/mailbox/Kconfig                            |   8 ++
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/mailbox.c                          |  16 ++-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            | 129 +++++++++++++++++++++
 5 files changed, 195 insertions(+), 6 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
 create mode 100644 drivers/mailbox/qcom-apcs-ipc-mailbox.c
