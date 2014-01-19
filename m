From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 19 Jan 2014 19:58:16 +0100
Subject: [PATCH v3 00/24] drm/i2c: tda998x: add DT support and other
 improvements
Message-ID: <20140119195816.0dd8eeaf@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set contains various extensions to the tda998x driver:

- simplify the i2c read/write
- code cleanup and fix some small errors
- use HDMI constants
- don't read write-only registers
- add DT support
- use irq for connection status and EDID read
- get a better status of the HDMI connector

- v3
    - remarks from Russell King
	- more comments about the patches
	- change variable name instead of copy (patch 7)
	- add 'fix bad value in the AIF' (patch 8)
	- add 'fix a NULL pointer dereference' (patch 13)
	- add 'add DT documentation' (patch 16)
	- remove 'use the tda998x video format when cea mode'
	- remove 'change the video quantization
	- remove 'fix the value of the TBG_CNTRL_1 register'
	- remove 'tda998x: move the TBG_CNTRL_0 register setting'
	- change fields of the register AIP_CLKSEL (patch 19)
	- remove 'adjust the audio CTS to the mode clock'
	- don't put a comment between field definition (patch 23)
    - some more remarks may be found in the patches 10, 14, 15
    - removal of the tda codec interface which will be the subject
		of an other patch series
- v2
	- decompose patches with different topics
	- fix some bad i2c register values
	- add audio codec interface

Jean-Francois Moine (24):
  drm/i2c: tda998x: simplify the i2c read/write functions
  drm/i2c: tda998x: check more I/O errors
  drm/i2c: tda998x: code cleanup
  drm/i2c: tda998x: change probe message origin
  drm/i2c: tda998x: don't freeze the system at audio startup time
  drm/i2c: tda998x: force the page register at startup time
  drm/i2c: tda998x: set the video mode from the adjusted value
  drm/i2c: tda998x: fix bad value in the AIF
  drm/i2c: tda998x: use HDMI constants
  drm/i2c: tda998x: don't read write-only registers
  drm/i2c: tda998x: free the CEC device on encoder_destroy
  drm/i2c: tda998x: check the CEC device creation
  drm/i2c: tda998x: fix a NULL pointer dereference
  drm/i2c: tda998x: add DT support
  drm/i2c: tda998x: use irq for connection status and EDID read
  drm/i2c: tda998x: add DT documentation
  drm/i2c: tda998x: get a better status of the connection
  drm/i2c: tda998x: fix the ENABLE_SPACE register
  drm/i2c: tda998x: use global constants
  drm/i2c: tda998x: remove the unused variable ca_i2s
  drm/i2c: tda998x: add the active aspect in HDMI AVI frame
  drm/i2c: tda998x: change the frequence in the audio channel
  drm/i2c: tda998x: code optimization
  drm/i2c: tda998x: adjust the audio clock divider for S/PDIF

 .../devicetree/bindings/drm/i2c/tda998x.txt        |  24 +
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 711 +++++++++++++--------
 include/drm/i2c/tda998x.h                          |   6 +-
 3 files changed, 478 insertions(+), 263 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/drm/i2c/tda998x.txt

-- 
1.8.5.3
