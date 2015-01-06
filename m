From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  6 Jan 2015 12:08:42 +0100
Subject: [RESEND PATCH v5 0/3] drm: describe display bus format
Message-ID: <1420542525-13507-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Resending this series I depends on for the Atmel HLCDC driver which, BTW,
I really expect to be merged in 3.20.
Thierry, do you see any remaining issues that should be fixed ?
If not, Dave, Thierry, could you take it for 3.20 (or, if you prefer, I
could make it part of my PR for the atmel-hlcdc driver inclusion).

Here follows the usual description:

This series makes use of the MEDIA_BUS_FMT definition to describe how
the data are transmitted to the display.

This will allow drivers to configure their output display bus according
to the display capabilities.
For example some display controllers support DPI (or raw RGB) connectors
and need to specify which format will be transmitted on the DPI bus
(RGB444, RGB565, RGB888, ...).

This series also adds a field to the panel_desc struct so that one
can specify which format is natevely supported by a panel.

Regards,

Boris

Changes since v4:
 - fix typo
 - fix 'line over 80 characters' warnings
 - fix leak of formats array

Changes since v3:
 - store num_bus_formats on an unsigned int
 - clearly state that fmts argument (in drm_display_info_set_bus_formats
   function) should be an array of MEDIA_BUS_FMT_* values.

Changes since v2:
 - use the MEDIA_BUS_FMT macros

Changes since v1:
 - rename nformats into num_formats
 - declare num_formats as an unsigned int


Boris Brezillon (3):
  drm: add bus_formats and num_bus_formats fields to drm_display_info
  drm: panel: simple-panel: add support for bus_format retrieval
  drm: panel: simple-panel: add bus format information for foxlink panel

 drivers/gpu/drm/drm_crtc.c           | 35 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c |  6 ++++++
 include/drm/drm_crtc.h               |  8 ++++++++
 3 files changed, 49 insertions(+)

-- 
1.9.1
