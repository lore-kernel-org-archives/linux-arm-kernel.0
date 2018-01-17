From: bogdan.purcareata@nxp.com (Bogdan Purcareata)
Date: Wed, 17 Jan 2018 18:36:44 +0200
Subject: [PATCH v2] staging: fsl-mc: Add SPDX license identifiers
Message-ID: <1516207004-24407-1-git-send-email-bogdan.purcareata@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fsl-mc bus and dpio driver files use a combination of GPL-2.0 and
GPL-2.0+ OR BSD-3-Clause licenses. Add SPDX tags and delete the full
license text, keeping the existing license for each file. Add GPL-2.0
for Kconfig / Makefile, where not present.

Signed-off-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
v1 -> v2:
- keep existing license for each file, only update to use SPDX tags,
  don't change the license

 drivers/staging/fsl-mc/Kconfig                     |  1 +
 drivers/staging/fsl-mc/Makefile                    |  1 +
 drivers/staging/fsl-mc/bus/Kconfig                 |  3 +-
 drivers/staging/fsl-mc/bus/Makefile                |  3 +-
 drivers/staging/fsl-mc/bus/dpbp-cmd.h              | 28 +------------------
 drivers/staging/fsl-mc/bus/dpbp.c                  | 28 +------------------
 drivers/staging/fsl-mc/bus/dpcon-cmd.h             | 28 +------------------
 drivers/staging/fsl-mc/bus/dpcon.c                 | 32 ++--------------------
 drivers/staging/fsl-mc/bus/dpio/Makefile           |  1 +
 drivers/staging/fsl-mc/bus/dpio/dpio-cmd.h         | 28 +------------------
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c      | 27 +-----------------
 drivers/staging/fsl-mc/bus/dpio/dpio-service.c     | 27 +-----------------
 drivers/staging/fsl-mc/bus/dpio/dpio.c             | 28 +------------------
 drivers/staging/fsl-mc/bus/dpio/dpio.h             | 28 +------------------
 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c     | 27 +-----------------
 drivers/staging/fsl-mc/bus/dpio/qbman-portal.h     | 27 +-----------------
 drivers/staging/fsl-mc/bus/dpmcp.c                 | 28 +------------------
 drivers/staging/fsl-mc/bus/dprc-driver.c           |  4 +--
 drivers/staging/fsl-mc/bus/dprc.c                  | 28 +------------------
 drivers/staging/fsl-mc/bus/fsl-mc-allocator.c      |  4 +--
 drivers/staging/fsl-mc/bus/fsl-mc-bus.c            |  4 +--
 drivers/staging/fsl-mc/bus/fsl-mc-msi.c            |  4 +--
 drivers/staging/fsl-mc/bus/fsl-mc-private.h        |  4 +--
 .../staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c |  4 +--
 drivers/staging/fsl-mc/bus/mc-io.c                 | 28 +------------------
 drivers/staging/fsl-mc/bus/mc-sys.c                | 28 +------------------
 drivers/staging/fsl-mc/include/dpaa2-fd.h          | 27 +-----------------
 drivers/staging/fsl-mc/include/dpaa2-global.h      | 27 +-----------------
 drivers/staging/fsl-mc/include/dpaa2-io.h          | 27 +-----------------
 drivers/staging/fsl-mc/include/dpbp.h              | 29 +-------------------
 drivers/staging/fsl-mc/include/dpcon.h             | 32 ++--------------------
 drivers/staging/fsl-mc/include/mc.h                |  4 +--
 32 files changed, 36 insertions(+), 563 deletions(-)

diff --git a/drivers/staging/fsl-mc/Kconfig b/drivers/staging/fsl-mc/Kconfig
index 32df07b..3002229 100644
--- a/drivers/staging/fsl-mc/Kconfig
+++ b/drivers/staging/fsl-mc/Kconfig
@@ -1 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
 source "drivers/staging/fsl-mc/bus/Kconfig"
diff --git a/drivers/staging/fsl-mc/Makefile b/drivers/staging/fsl-mc/Makefile
index 9c6a001..1468388 100644
--- a/drivers/staging/fsl-mc/Makefile
+++ b/drivers/staging/fsl-mc/Makefile
@@ -1,2 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
 # Freescale Management Complex (MC) bus drivers
 obj-$(CONFIG_FSL_MC_BUS)	+= bus/
diff --git a/drivers/staging/fsl-mc/bus/Kconfig b/drivers/staging/fsl-mc/bus/Kconfig
index 504c987..1f91000 100644
--- a/drivers/staging/fsl-mc/bus/Kconfig
+++ b/drivers/staging/fsl-mc/bus/Kconfig
@@ -1,10 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # DPAA2 fsl-mc bus
 #
 # Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
 #
-# This file is released under the GPLv2
-#
 
 config FSL_MC_BUS
 	bool "QorIQ DPAA2 fsl-mc bus driver"
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
index 6df407e..29059db 100644
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ b/drivers/staging/fsl-mc/bus/Makefile
@@ -1,10 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Freescale Management Complex (MC) bus drivers
 #
 # Copyright (C) 2014 Freescale Semiconductor, Inc.
 #
-# This file is released under the GPLv2
-#
 obj-$(CONFIG_FSL_MC_BUS) += mc-bus-driver.o
 
 mc-bus-driver-objs := fsl-mc-bus.o \
diff --git a/drivers/staging/fsl-mc/bus/dpbp-cmd.h b/drivers/staging/fsl-mc/bus/dpbp-cmd.h
index 5904836..0b7f5c0 100644
--- a/drivers/staging/fsl-mc/bus/dpbp-cmd.h
+++ b/drivers/staging/fsl-mc/bus/dpbp-cmd.h
@@ -1,33 +1,7 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- * * Redistributions of source code must retain the above copyright
- * notice, this list of conditions and the following disclaimer.
- * * Redistributions in binary form must reproduce the above copyright
- * notice, this list of conditions and the following disclaimer in the
- * documentation and/or other materials provided with the distribution.
- * * Neither the name of the above-listed copyright holders nor the
- * names of any contributors may be used to endorse or promote products
- * derived from this software without specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
  */
 #ifndef _FSL_DPBP_CMD_H
 #define _FSL_DPBP_CMD_H
diff --git a/drivers/staging/fsl-mc/bus/dpbp.c b/drivers/staging/fsl-mc/bus/dpbp.c
index fc76e90..a4df846 100644
--- a/drivers/staging/fsl-mc/bus/dpbp.c
+++ b/drivers/staging/fsl-mc/bus/dpbp.c
@@ -1,33 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- * * Redistributions of source code must retain the above copyright
- * notice, this list of conditions and the following disclaimer.
- * * Redistributions in binary form must reproduce the above copyright
- * notice, this list of conditions and the following disclaimer in the
- * documentation and/or other materials provided with the distribution.
- * * Neither the name of the above-listed copyright holders nor the
- * names of any contributors may be used to endorse or promote products
- * derived from this software without specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/kernel.h>
 #include "../include/mc.h"
diff --git a/drivers/staging/fsl-mc/bus/dpcon-cmd.h b/drivers/staging/fsl-mc/bus/dpcon-cmd.h
index d2ba819..27fa098 100644
--- a/drivers/staging/fsl-mc/bus/dpcon-cmd.h
+++ b/drivers/staging/fsl-mc/bus/dpcon-cmd.h
@@ -1,33 +1,7 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- * * Redistributions of source code must retain the above copyright
- * notice, this list of conditions and the following disclaimer.
- * * Redistributions in binary form must reproduce the above copyright
- * notice, this list of conditions and the following disclaimer in the
- * documentation and/or other materials provided with the distribution.
- * * Neither the name of the above-listed copyright holders nor the
- * names of any contributors may be used to endorse or promote products
- * derived from this software without specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
  */
 #ifndef _FSL_DPCON_CMD_H
 #define _FSL_DPCON_CMD_H
diff --git a/drivers/staging/fsl-mc/bus/dpcon.c b/drivers/staging/fsl-mc/bus/dpcon.c
index 5ba1a0f..8f84d7b 100644
--- a/drivers/staging/fsl-mc/bus/dpcon.c
+++ b/drivers/staging/fsl-mc/bus/dpcon.c
@@ -1,33 +1,7 @@
-/* Copyright 2013-2016 Freescale Semiconductor Inc.
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2013-2016 Freescale Semiconductor Inc.
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- * * Redistributions of source code must retain the above copyright
- * notice, this list of conditions and the following disclaimer.
- * * Redistributions in binary form must reproduce the above copyright
- * notice, this list of conditions and the following disclaimer in the
- * documentation and/or other materials provided with the distribution.
- * * Neither the name of the above-listed copyright holders nor the
- * names of any contributors may be used to endorse or promote products
- * derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/kernel.h>
 #include "../include/mc.h"
diff --git a/drivers/staging/fsl-mc/bus/dpio/Makefile b/drivers/staging/fsl-mc/bus/dpio/Makefile
index 837d330..53ba84d 100644
--- a/drivers/staging/fsl-mc/bus/dpio/Makefile
+++ b/drivers/staging/fsl-mc/bus/dpio/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # QorIQ DPAA2 DPIO driver
 #
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-cmd.h b/drivers/staging/fsl-mc/bus/dpio/dpio-cmd.h
index b2dc6e7..ab8f82e 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-cmd.h
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-cmd.h
@@ -1,34 +1,8 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016 NXP
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- * * Redistributions of source code must retain the above copyright
- * notice, this list of conditions and the following disclaimer.
- * * Redistributions in binary form must reproduce the above copyright
- * notice, this list of conditions and the following disclaimer in the
- * documentation and/or other materials provided with the distribution.
- * * Neither the name of the above-listed copyright holders nor the
- * names of any contributors may be used to endorse or promote products
- * derived from this software without specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
  */
 #ifndef _FSL_DPIO_CMD_H
 #define _FSL_DPIO_CMD_H
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
index e36da20..b8479ef 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
@@ -1,33 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
  * Copyright 2014-2016 Freescale Semiconductor Inc.
  * Copyright NXP 2016
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *	 notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *	 notice, this list of conditions and the following disclaimer in the
- *	 documentation and/or other materials provided with the distribution.
- *     * Neither the name of Freescale Semiconductor nor the
- *	 names of its contributors may be used to endorse or promote products
- *	 derived from this software without specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
 #include <linux/types.h>
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
index 6e8994c..d3c8462 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
@@ -1,33 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
  * Copyright 2014-2016 Freescale Semiconductor Inc.
  * Copyright 2016 NXP
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *	 notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *	 notice, this list of conditions and the following disclaimer in the
- *	 documentation and/or other materials provided with the distribution.
- *     * Neither the name of Freescale Semiconductor nor the
- *	 names of its contributors may be used to endorse or promote products
- *	 derived from this software without specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/types.h>
 #include "../../include/mc.h"
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio.c b/drivers/staging/fsl-mc/bus/dpio/dpio.c
index 00eb221..20cdeae 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio.c
@@ -1,34 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016 NXP
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- * * Redistributions of source code must retain the above copyright
- * notice, this list of conditions and the following disclaimer.
- * * Redistributions in binary form must reproduce the above copyright
- * notice, this list of conditions and the following disclaimer in the
- * documentation and/or other materials provided with the distribution.
- * * Neither the name of the above-listed copyright holders nor the
- * names of any contributors may be used to endorse or promote products
- * derived from this software without specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/kernel.h>
 #include "../../include/mc.h"
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio.h b/drivers/staging/fsl-mc/bus/dpio/dpio.h
index ced1103..49194c8 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio.h
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio.h
@@ -1,34 +1,8 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  * Copyright 2016 NXP
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- * * Redistributions of source code must retain the above copyright
- * notice, this list of conditions and the following disclaimer.
- * * Redistributions in binary form must reproduce the above copyright
- * notice, this list of conditions and the following disclaimer in the
- * documentation and/or other materials provided with the distribution.
- * * Neither the name of the above-listed copyright holders nor the
- * names of any contributors may be used to endorse or promote products
- * derived from this software without specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
  */
 #ifndef __FSL_DPIO_H
 #define __FSL_DPIO_H
diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
index 163bdac..376e9ed 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
+++ b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
@@ -1,33 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
  * Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
  * Copyright 2016 NXP
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Freescale Semiconductor nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
 #include <asm/cacheflush.h>
diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
index 8428559..fb8b9d3 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
+++ b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
@@ -1,33 +1,8 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
  * Copyright 2016 NXP
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Freescale Semiconductor nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #ifndef __FSL_QBMAN_PORTAL_H
 #define __FSL_QBMAN_PORTAL_H
diff --git a/drivers/staging/fsl-mc/bus/dpmcp.c b/drivers/staging/fsl-mc/bus/dpmcp.c
index 63b967c..be07c77 100644
--- a/drivers/staging/fsl-mc/bus/dpmcp.c
+++ b/drivers/staging/fsl-mc/bus/dpmcp.c
@@ -1,33 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- * * Redistributions of source code must retain the above copyright
- * notice, this list of conditions and the following disclaimer.
- * * Redistributions in binary form must reproduce the above copyright
- * notice, this list of conditions and the following disclaimer in the
- * documentation and/or other materials provided with the distribution.
- * * Neither the name of the above-listed copyright holders nor the
- * names of any contributors may be used to endorse or promote products
- * derived from this software without specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/kernel.h>
 #include "../include/mc.h"
diff --git a/drivers/staging/fsl-mc/bus/dprc-driver.c b/drivers/staging/fsl-mc/bus/dprc-driver.c
index 638a2dc..b090757 100644
--- a/drivers/staging/fsl-mc/bus/dprc-driver.c
+++ b/drivers/staging/fsl-mc/bus/dprc-driver.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Freescale data path resource container (DPRC) driver
  *
  * Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
  * Author: German Rivera <German.Rivera@freescale.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/module.h>
diff --git a/drivers/staging/fsl-mc/bus/dprc.c b/drivers/staging/fsl-mc/bus/dprc.c
index 093a464..97f5172 100644
--- a/drivers/staging/fsl-mc/bus/dprc.c
+++ b/drivers/staging/fsl-mc/bus/dprc.c
@@ -1,33 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- * * Redistributions of source code must retain the above copyright
- * notice, this list of conditions and the following disclaimer.
- * * Redistributions in binary form must reproduce the above copyright
- * notice, this list of conditions and the following disclaimer in the
- * documentation and/or other materials provided with the distribution.
- * * Neither the name of the above-listed copyright holders nor the
- * names of any contributors may be used to endorse or promote products
- * derived from this software without specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/kernel.h>
 #include "../include/mc.h"
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c b/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
index 2f77597..8f313a4 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fsl-mc object allocator driver
  *
  * Copyright (C) 2013-2016 Freescale Semiconductor, Inc.
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/module.h>
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
index db2c0be..1b333c4 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Freescale Management Complex (MC) bus driver
  *
  * Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
  * Author: German Rivera <German.Rivera@freescale.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) "fsl-mc: " fmt
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-msi.c b/drivers/staging/fsl-mc/bus/fsl-mc-msi.c
index 625ba07..971ad87 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-msi.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Freescale Management Complex (MC) bus driver MSI support
  *
  * Copyright (C) 2015-2016 Freescale Semiconductor, Inc.
  * Author: German Rivera <German.Rivera@freescale.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/of_device.h>
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-private.h b/drivers/staging/fsl-mc/bus/fsl-mc-private.h
index 57e6b7a..83b89d6 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-private.h
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-private.h
@@ -1,11 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Freescale Management Complex (MC) bus private declarations
  *
  * Copyright (C) 2016 Freescale Semiconductor, Inc.
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #ifndef _FSL_MC_PRIVATE_H_
 #define _FSL_MC_PRIVATE_H_
diff --git a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
index ffeaea5..7fbf0a7 100644
--- a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Freescale Management Complex (MC) bus driver MSI support
  *
  * Copyright (C) 2015-2016 Freescale Semiconductor, Inc.
  * Author: German Rivera <German.Rivera@freescale.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/of_device.h>
diff --git a/drivers/staging/fsl-mc/bus/mc-io.c b/drivers/staging/fsl-mc/bus/mc-io.c
index 563cf22..7e6fb36 100644
--- a/drivers/staging/fsl-mc/bus/mc-io.c
+++ b/drivers/staging/fsl-mc/bus/mc-io.c
@@ -1,33 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of the above-listed copyright holders nor the
- *       names of any contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
  */
 
 #include <linux/io.h>
diff --git a/drivers/staging/fsl-mc/bus/mc-sys.c b/drivers/staging/fsl-mc/bus/mc-sys.c
index 147214a..f09d75d 100644
--- a/drivers/staging/fsl-mc/bus/mc-sys.c
+++ b/drivers/staging/fsl-mc/bus/mc-sys.c
@@ -1,35 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  *
  * I/O services to send MC commands to the MC hardware
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of the above-listed copyright holders nor the
- *       names of any contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
  */
 
 #include <linux/delay.h>
diff --git a/drivers/staging/fsl-mc/include/dpaa2-fd.h b/drivers/staging/fsl-mc/include/dpaa2-fd.h
index cf7857f..3e02200 100644
--- a/drivers/staging/fsl-mc/include/dpaa2-fd.h
+++ b/drivers/staging/fsl-mc/include/dpaa2-fd.h
@@ -1,33 +1,8 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * Copyright 2014-2016 Freescale Semiconductor Inc.
  * Copyright 2016 NXP
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Freescale Semiconductor nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #ifndef __FSL_DPAA2_FD_H
 #define __FSL_DPAA2_FD_H
diff --git a/drivers/staging/fsl-mc/include/dpaa2-global.h b/drivers/staging/fsl-mc/include/dpaa2-global.h
index 0326447..9bc0713 100644
--- a/drivers/staging/fsl-mc/include/dpaa2-global.h
+++ b/drivers/staging/fsl-mc/include/dpaa2-global.h
@@ -1,33 +1,8 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * Copyright 2014-2016 Freescale Semiconductor Inc.
  * Copyright 2016 NXP
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Freescale Semiconductor nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #ifndef __FSL_DPAA2_GLOBAL_H
 #define __FSL_DPAA2_GLOBAL_H
diff --git a/drivers/staging/fsl-mc/include/dpaa2-io.h b/drivers/staging/fsl-mc/include/dpaa2-io.h
index 9d70251..9cb1eec 100644
--- a/drivers/staging/fsl-mc/include/dpaa2-io.h
+++ b/drivers/staging/fsl-mc/include/dpaa2-io.h
@@ -1,33 +1,8 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * Copyright 2014-2016 Freescale Semiconductor Inc.
  * Copyright NXP
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of Freescale Semiconductor nor the
- *       names of its contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
- * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
- * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
- * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
- * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #ifndef __FSL_DPAA2_IO_H
 #define __FSL_DPAA2_IO_H
diff --git a/drivers/staging/fsl-mc/include/dpbp.h b/drivers/staging/fsl-mc/include/dpbp.h
index e9e04cc..4a18096 100644
--- a/drivers/staging/fsl-mc/include/dpbp.h
+++ b/drivers/staging/fsl-mc/include/dpbp.h
@@ -1,34 +1,7 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * Copyright 2013-2016 Freescale Semiconductor Inc.
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- * * Redistributions of source code must retain the above copyright
- * notice, this list of conditions and the following disclaimer.
- * * Redistributions in binary form must reproduce the above copyright
- * notice, this list of conditions and the following disclaimer in the
- * documentation and/or other materials provided with the distribution.
- * * Neither the name of the above-listed copyright holders nor the
- * names of any contributors may be used to endorse or promote products
- * derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
  */
 #ifndef __FSL_DPBP_H
 #define __FSL_DPBP_H
diff --git a/drivers/staging/fsl-mc/include/dpcon.h b/drivers/staging/fsl-mc/include/dpcon.h
index 425749e..062e90a 100644
--- a/drivers/staging/fsl-mc/include/dpcon.h
+++ b/drivers/staging/fsl-mc/include/dpcon.h
@@ -1,33 +1,7 @@
-/* Copyright 2013-2016 Freescale Semiconductor Inc.
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright 2013-2016 Freescale Semiconductor Inc.
  *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- * * Redistributions of source code must retain the above copyright
- * notice, this list of conditions and the following disclaimer.
- * * Redistributions in binary form must reproduce the above copyright
- * notice, this list of conditions and the following disclaimer in the
- * documentation and/or other materials provided with the distribution.
- * * Neither the name of the above-listed copyright holders nor the
- * names of any contributors may be used to endorse or promote products
- * derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
  */
 #ifndef __FSL_DPCON_H
 #define __FSL_DPCON_H
diff --git a/drivers/staging/fsl-mc/include/mc.h b/drivers/staging/fsl-mc/include/mc.h
index 34d79a8..765ba41 100644
--- a/drivers/staging/fsl-mc/include/mc.h
+++ b/drivers/staging/fsl-mc/include/mc.h
@@ -1,12 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Freescale Management Complex (MC) bus public interface
  *
  * Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
  * Author: German Rivera <German.Rivera@freescale.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #ifndef _FSL_MC_H_
 #define _FSL_MC_H_
-- 
2.7.4
