From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Wed, 27 May 2015 02:43:53 -0700
Subject: [PATH] Fix ies/smt and register irq fail bug.
Message-ID: <1432719835-18939-1-git-send-email-hongzhou.yang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
After integration test, we found some bugs in the code you just merged.
The first is that I missed ies/smt configuration for MSDC3.
The seconed is the if judgement for "interrupt-controller" I added last
time should on the contrary. So adding these two patches to fix them.
Sorry about this. And please help to merge them, many thanks.

These patches include below changes:
- Adding MSDC3 ies/smt support for mt8173.
- Since mt6397 is no need to support interrupt controller,
I judged "interrupt-controller" property to skip it last time,
but the if judgement should on the contrary, this is a bug.
so adding this patch to fix it. 
 
Hongzhou Yang (2):
  pinctrl: mediatek: Fix bug of ies/smt setting for mt8173.
  pinctrl: mediatek: Fix pinctrl register irq fail bug.

 drivers/pinctrl/mediatek/pinctrl-mt8173.c     |   10 +++++++++-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    4 ++--
 2 files changed, 11 insertions(+), 3 deletions(-)

--
1.7.9.5
