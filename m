From: roy.pledge@nxp.com (Roy Pledge)
Date: Mon, 23 Jul 2018 12:00:25 -0500
Subject: [PATCH v2 4/4] drivers/soc/fsl/dpio: Convert DPIO documentation to
 .rst
In-Reply-To: <20180723170025.2259-1-roy.pledge@nxp.com>
References: <20180723170025.2259-1-roy.pledge@nxp.com>
Message-ID: <20180723170025.2259-5-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the Datapath I/O documentation to .rst format
and move to the Documation/networking/dpaa2 directory

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 .../networking/dpaa2/dpio-driver.rst               | 30 +++++++++++++++++++---
 Documentation/networking/dpaa2/index.rst           |  1 +
 2 files changed, 28 insertions(+), 3 deletions(-)
 rename drivers/soc/fsl/dpio/dpio-driver.txt => Documentation/networking/dpaa2/dpio-driver.rst (94%)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.txt b/Documentation/networking/dpaa2/dpio-driver.rst
similarity index 94%
rename from drivers/soc/fsl/dpio/dpio-driver.txt
rename to Documentation/networking/dpaa2/dpio-driver.rst
index 72ba9da..3a33a33 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.txt
+++ b/Documentation/networking/dpaa2/dpio-driver.rst
@@ -1,7 +1,16 @@
-Copyright 2016 NXP
+.. include:: <isonum.txt>
+
+DPAA2 DPIO (Data Path I/O) Overview
+===================================
+
+:Copyright: |copy| 2015 Freescale Semiconductor Inc.
+:Copyright: |copy| 2018 NXP
+
+This document provides an overview of the Freescale DPAA2 DPIO
+drivers
 
 Introduction
-------------
+============
 
 A DPAA2 DPIO (Data Path I/O) is a hardware object that provides
 interfaces to enqueue and dequeue frames to/from network interfaces
@@ -27,8 +36,11 @@ provides services that:
 
 The Linux DPIO driver consists of 3 primary components--
    DPIO object driver-- fsl-mc driver that manages the DPIO object
+
    DPIO service-- provides APIs to other Linux drivers for services
+
    QBman portal interface-- sends portal commands, gets responses
+::
 
           fsl-mc          other
            bus           drivers
@@ -45,8 +57,9 @@ The Linux DPIO driver consists of 3 primary components--
                             |
                          hardware
 
+
 The diagram below shows how the DPIO driver components fit with the other
-DPAA2 Linux driver components:
+DPAA2 Linux driver components::
                                                    +------------+
                                                    | OS Network |
                                                    |   Stack    |
@@ -98,20 +111,29 @@ DPIO service  (dpio-service.c, dpaa2-io.h)
 
    Notification handling
       dpaa2_io_service_register()
+
       dpaa2_io_service_deregister()
+
       dpaa2_io_service_rearm()
 
    Queuing
       dpaa2_io_service_pull_fq()
+
       dpaa2_io_service_pull_channel()
+
       dpaa2_io_service_enqueue_fq()
+
       dpaa2_io_service_enqueue_qd()
+
       dpaa2_io_store_create()
+
       dpaa2_io_store_destroy()
+
       dpaa2_io_store_next()
 
    Buffer pool management
       dpaa2_io_service_release()
+
       dpaa2_io_service_acquire()
 
 QBman portal interface (qbman-portal.c)
@@ -120,7 +142,9 @@ QBman portal interface (qbman-portal.c)
    The qbman-portal component provides APIs to do the low level hardware
    bit twiddling for operations such as:
       -initializing Qman software portals
+
       -building and sending portal commands
+
       -portal interrupt configuration and processing
 
    The qbman-portal APIs are not public to other drivers, and are
diff --git a/Documentation/networking/dpaa2/index.rst b/Documentation/networking/dpaa2/index.rst
index 4c6586c..10bea11 100644
--- a/Documentation/networking/dpaa2/index.rst
+++ b/Documentation/networking/dpaa2/index.rst
@@ -6,3 +6,4 @@ DPAA2 Documentation
    :maxdepth: 1
 
    overview
+   dpio-driver
-- 
2.7.4
