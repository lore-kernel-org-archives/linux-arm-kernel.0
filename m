From: zonque@gmail.com (Daniel Mack)
Date: Mon, 12 Aug 2013 10:37:13 +0200
Subject: [PATCH 0/5] ARM: pxa: ssp: prepare for devicetree usage
Message-ID: <1376296638-19804-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

this is an excerpt of my pxa-dma patches that can be merged
independantly.

In contrast to what I already posted, this one contains a patch to make
ssp ports lookups from device nodes possible. As described in the
Documentation, users of ssp ports just reference the upstream by phandle.

The rest of the dma conversion will take more time anyway, so let's
better merge it step by step.


Thanks,
Daniel


Daniel Mack (5):
  ARM: pxa: ssp: remove unnecessary warning on kzalloc() failure
  ARM: pxa: ssp: add shortcut for &pdev->dev
  ARM: pxa: ssp: add DT bindings
  ARM: pxa: ssp: use devm_ functions
  ARM: pxa: ssp: add pxa_ssp_request_of()

 .../devicetree/bindings/serial/mrvl,pxa-ssp.txt    |  65 ++++++++
 arch/arm/plat-pxa/ssp.c                            | 174 ++++++++++++++-------
 include/linux/pxa2xx_ssp.h                         |  11 ++
 3 files changed, 193 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt

-- 
1.8.3.1
