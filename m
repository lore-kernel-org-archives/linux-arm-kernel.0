From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 13 Sep 2011 09:46:03 +0530
Subject: [PATCH v3 0/2] Add device tree support for Samsung's I2C driver
Message-ID: <1315887365-30532-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds device tree support for Samsung's I2C driver.

Changes since v2:
- Addressed all comments from Grant Likely
    - Used dev_kzalloc to allocate memory for platform data.
    - Removed redundant check while adding i2c adapter.
- Added support to retrieve gpio pin information from dt and request
  gpio pins (retained Grant's Ack even though this is a new addition
  in this version of the patch).

Changes since v1:
- Addressed all comments from Grant Likely
    - s3c24xx_i2c_is2440 function is simpler now.
    - Consolidated all the scatterd dt support code into a single function
      to make the dt support code non-invasive.
    - but the dependency on i2c pinmux handler function passed from the
      platform data is retained. It would be removed eventually when the
      new pinmux api is finalized and the i2c driver is modified to
      support the pinmux settings using the pinmux api.

Thomas Abraham (2):
  i2c: s3c2410: Keep a copy of platform data and use it
  i2c: s3c2410: Add device tree support

 .../devicetree/bindings/i2c/samsung-i2c.txt        |   39 ++++++
 drivers/i2c/busses/i2c-s3c2410.c                   |  128 ++++++++++++++++++--
 2 files changed, 159 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/samsung-i2c.txt
