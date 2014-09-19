From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Fri, 19 Sep 2014 10:08:11 +0200
Subject: [PATCH 0/2 v2]  Add OF match tables for the ChromeOs EC subdevices
Message-ID: <1411114093-3505-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ This is essentially a resend, adding Javiers reviewed-by and fixing some small
identation issues in the second patch. Also added Wolfgang and Dimitry in the
to, as i missed them last time ]

The ChromeOS EC MFD driver registers its sub-devices with both a (platform)
name and an OF compatibility string. As a result of this the modalias passed on
to user-space will be based on the OF compatibility string. Thus to be able to
rely on autoloading in case the subdevices are build as modules they need to
export the necessary module aliases based to match the of information.

The two patches in these series add the requird of match information to the EC
subdevices

I guess the first patch should through the i2c tree while the second one would
be for the input tree?

Sjoerd Simons (2):
  i2c: cros-ec-tunnel: Add of match table
  input: cros_ec_keyb: Add of match table

 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 9 +++++++++
 drivers/input/keyboard/cros_ec_keyb.c   | 9 +++++++++
 2 files changed, 18 insertions(+)

-- 
2.1.0
