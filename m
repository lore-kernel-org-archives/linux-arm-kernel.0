From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 25 Mar 2017 19:43:49 +0100
Subject: [PATCH 0/1] pinctrl-meson8b: fix the NAND DQS pin definitions
Message-ID: <20170325184350.7677-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently do not have a NAND driver but once we have one this will
become handy:
The current nand_dqs_0 and nand_dqs_1 groups are not usable because the
"nand" function only allows "nand_dqs0" and "nand_dqs1" (no underscore
after "nand_dqs").

While here, also rename the groups to "nand_dqs_15" (uses pin 15) and
"nand_dqs_18" (uses pin 18).
Renaming is safe in this case as it was not possible to use these
groups/pins before (so we can be sure that there are no "old DT
consumers" out there).


Martin Blumenstingl (1):
  pinctrl: meson: meson8b: fix the NAND DQS pins

 drivers/pinctrl/meson/pinctrl-meson8b.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.12.1
