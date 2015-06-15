From: koro.chen@mediatek.com (Koro Chen)
Date: Mon, 15 Jun 2015 22:38:01 +0800
Subject: [PATCH v2 0/3] ASoC: Mediatek: Add support for MT8173 SOC 
Message-ID: <1434379084-26026-1-git-send-email-koro.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds basic support for the Mediatek AFE (Audio Front End) unit of MT8173.
This patch is based on Linux 4.1-rc1 and Sascha's SCPSYS power patch [1].

The AFE unit comprises several memory interfaces that communicate with CPU, 
a multi input multi output digital audio interconnect, 
and several external interfaces (e.g. I2S).

[1] https://lkml.org/lkml/2015/6/9/172

changes since v1:
- change Kconfig to tristate
- remove unnecessary !! in the platform driver
- let MODULE_DEVICE_TABLE follow the table
- remove regulators from machine drivers

changes since RFC:
- Use DPCM to model AFE
  AFE memory interfaces such as DL1, VUL are modeled as frontend DAIs,
  and AFE IOs such as I2S, HDMI are backend DAIs.
  Which memif and IO to be used can be set in the machine driver.
  There is no need to indicate this in dts anymore so
  include/dt-bindings/sound/mtk-afe.h is removed.
  AFE connections are represented by DAPM widgets and routes, and
  set connection APIs/tables are no longer required.
  (mtk-afe-connection.c and mtk-afe-connection.h are removed)
