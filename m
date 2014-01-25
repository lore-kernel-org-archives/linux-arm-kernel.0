From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 25 Jan 2014 18:14:47 +0100
Subject: [PATCH v4 00/24] drm/i2c: tda998x: add DT support and other
 improvements
Message-ID: <20140125181447.6eeff090@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set contains various extensions to the tda998x driver:

- simplify the i2c read/write
- code cleanup and fix some small errors
- use global constants
- don't read write-only registers
- add DT support
- use irq for connection status and EDID read

- v4
    - remarks from Russell King (thank you, Russell)
	- more comments about the patches
	- remove 'fix a NULL pointer dereference'
	- get the IRQ number from the i2c client
	- remove 'get a better status of the connection'
	- split the previous 'fix the ENABLE_SPACE register'
	- add asounddef.h variables in 'change the frequence in the audio channel'
    - add 'always enable EDID read IRQ'
    - remove audio changes which will be in a next patch set about
      information exchanges with the audio subsystem
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
  drm/i2c: tda998x: add DT support
  drm/i2c: tda998x: always enable EDID read IRQ
  drm/i2c: tda998x: use irq for connection status and EDID read
  drm/i2c: tda998x: add DT documentation
  drm/i2c: tda998x: fix the ENABLE_SPACE register
  drm/i2c: tda998x: set the PLL division factor in range 0..3
  drm/i2c: tda998x: make the audio code more readable
  drm/i2c: tda998x: remove the unused variable ca_i2s
  drm/i2c: tda998x: add the active aspect in HDMI AVI frame
  drm/i2c: tda998x: change the frequence in the audio channel
  drm/i2c: tda998x: code optimization
  drm/i2c: tda998x: adjust the audio clock divider for S/PDIF

 .../devicetree/bindings/drm/i2c/tda998x.txt        |  26 +
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 660 +++++++++++++--------
 2 files changed, 435 insertions(+), 251 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/drm/i2c/tda998x.txt

-- 
1.8.5.3
