From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  8 Dec 2016 18:10:07 +0100
Subject: [PATCH 0/3] rtc: armada38x: Few improvement and cleanup
Message-ID: <20161208171010.29446-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series brings some improvement and cleanup for the armada 38x
RTC.

The errata for this RTC gave us more information on how to work around
it. The first patch implement it.

The second patch convert the driver to the time64_t usage.

And the last patch make the driver really usable on 64 bits
architecture.

These last two patches are a preliminary step allowing using this
driver on the Armada 7K/8K which are 64 bits ARM SoCs which use the
same RTC IP.

Thanks,

Gregory

Gregory CLEMENT (2):
  rtc: armada38x: Convert to time64_t
  rtc: armada38x: Prepare for being use on 64 bits

Shaker Daibes (1):
  rtc: armada38x: improve RTC errata implementation

 drivers/rtc/rtc-armada38x.c | 145 ++++++++++++++++++++++++++++++--------------
 1 file changed, 100 insertions(+), 45 deletions(-)

-- 
2.10.2
