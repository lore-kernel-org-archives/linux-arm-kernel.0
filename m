From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Sat, 23 Aug 2014 01:03:00 +0200
Subject: [PATCH 0/2] Add of match tables for the ChromeOs EC subdevices
Message-ID: <1408748582-29029-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ChromeOS EC MFD driver registers its sub-devices with both a (platform)
name and an of compatibility string. As a result of this the modalias passed on
to user-space will be based on the of compatibility string. Thus to be able to
rely on autoloading in case the subdevices are build as modules they need to
export the necessary module aliases based to match the of information.

The two patches in these series add the requird of match information to the EC
subdevices

Sjoerd Simons (2):
  i2c: cros-ec-tunnel: Add of match table
  input: cros_ec_keyb: Add of match table

 drivers/i2c/busses/i2c-cros-ec-tunnel.c |  9 +++++++++
 drivers/input/keyboard/cros_ec_keyb.c   | 10 ++++++++++
 2 files changed, 19 insertions(+)

-- 
2.1.0
