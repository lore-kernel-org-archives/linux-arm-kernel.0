From: zonque@gmail.com (Daniel Mack)
Date: Tue,  1 Oct 2013 15:51:32 +0200
Subject: [PATCH] ARM: omap: edma: add suspend suspend/resume hooks
Message-ID: <1380635493-31040-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for edma driver.

I know the intermediate code in arch/arm/common is going to be purged
eventually when the real dma-engine driver lands, so I don't know
whether it's reasonable to include my patch after all. It might just
server as template for the suspend/resume functions in the final
driver, or maybe anyone wants to include that intermediate hack for the
time being.

Successfully tested on an AM335x board with davinci-mcasp enabled
audio. A patch to make the latter work after suspend has been posted
on alsa-devel.


Thanks,
Dainel


Daniel Mack (1):
  ARM: omap: edma: add suspend suspend/resume hooks

 arch/arm/common/edma.c | 133 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

-- 
1.8.3.1
