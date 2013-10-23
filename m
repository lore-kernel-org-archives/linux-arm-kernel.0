From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 23 Oct 2013 09:39:28 +0200
Subject: [PATCH 0/10] drm/i2c: tda998x: add DT support and some extensions
Message-ID: <20131023093928.5ea73eca@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set contains various extensions to the tda998x driver.
While these extensions may not be related, each one is based on the
previous one.

The patches are:

 1- simplify the i2c read/write
 2- fix some small errors
 3- use HDMI constants
 4- don't read write-only registers
 5- add DT support
 6- use irq for connexion status and EDID read
 7- get a better status of the connexion
 8- use the tda998x video format if cea mode
 9- fix some video errors
10- fix some audio errors

This patch set does not fix:

- the random black screen at startup time.
  This problem seems due to a bad audio input (the image appears after
  streaming an audio file).

- the need to have the audio input port also declared in the audio
  subsystem (I use a DTized version of the simple-card).

- how the TDA998x audio registers must be updated when the audio
  streaming parameters change.

- how the EDID audio capabilities act on the audio subsystem.

The resulting driver has been tested on a SolidRun Cubox with my own
Dove DRM driver.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
