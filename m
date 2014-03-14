From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 14 Mar 2014 08:26:20 -0700
Subject: [PATCH 1/5] drivers: input: keyboard: st-keyscan: add keyscan
 driver
In-Reply-To: <5322D63D.5030403@st.com>
References: <1393990772-9567-1-git-send-email-gabriel.fernandez@st.com>
 <1393990772-9567-2-git-send-email-gabriel.fernandez@st.com>
 <20140310114819.GO14976@lee--X1> <5322D63D.5030403@st.com>
Message-ID: <20140314152620.GA27167@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 11:13:17AM +0100, Gabriel Fernandez wrote:
> Hi Lee,
> 
> On 03/10/2014 12:48 PM, Lee Jones wrote:
> >Hi Gabi,
> >
> >Sorry for the delay. It was a hectic week last week.
> >
> >As promised:
> >
> >>This patch adds ST Keyscan driver to use the keypad hw a subset
> >>of ST boards provide. Specific board setup will be put in the
> >>given dt.
> >>
> >>Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
> >>Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> >Are you sure these are in the correct order?
> ok i change the order
> 
> >>+- linux,keymap: The keymap for keys as described in the binding document
> >>+  devicetree/bindings/input/matrix-keymap.txt.
> >>+
> >>+- keypad,num-rows: Number of row lines connected to the keypad controller.
> >>+
> >>+- keypad,num-columns: Number of column lines connected to the keypad
> >>+  controller.
> >>+
> >>+- st,debounce_us: Debouncing interval time in microseconds
> >I'm sure there will be a shared binding for de-bounce.
> >
> >If not, there certainly should be.
> 
> you want to refer to "debounce-interval" ?
> 
> >
> >+Example:
> >+
> >+keyscan: keyscan at fe4b0000 {
> >+	compatible = "st,keypad";
> >Is there any way we can make this more specific to _this_ IP?
> for my knowledge this IP is the same for stixxxx platform.
> 
> 
> >
> >>+	  To compile this driver as a module, choose M here: the
> >>+	  module will be called stm-keyscan.
> >>+
> >>  config KEYBOARD_SUNKBD
> >>  	tristate "Sun Type 4 and Type 5 keyboard"
> >>  	select SERIO
> >>diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> >>index a699b61..5fd020a 100644
> >>--- a/drivers/input/keyboard/Makefile
> >>+++ b/drivers/input/keyboard/Makefile
> >>@@ -50,6 +50,7 @@ obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+= sh_keysc.o
> >>  obj-$(CONFIG_KEYBOARD_SPEAR)		+= spear-keyboard.o
> >>  obj-$(CONFIG_KEYBOARD_STMPE)		+= stmpe-keypad.o
> >>  obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
> >>+obj-$(CONFIG_KEYBOARD_ST_KEYSCAN)	+= st-keyscan.o
> >>  obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
> >>  obj-$(CONFIG_KEYBOARD_TC3589X)		+= tc3589x-keypad.o
> >>  obj-$(CONFIG_KEYBOARD_TEGRA)		+= tegra-kbc.o
> >>diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard/st-keyscan.c
> >>new file mode 100644
> >>index 0000000..606cc19
> >>--- /dev/null
> >>+++ b/drivers/input/keyboard/st-keyscan.c
> >>@@ -0,0 +1,323 @@
> >>+/*
> >>+ * STMicroelectronics Key Scanning driver
> >>+ *
> >>+ * Copyright (c) 2014 STMicroelectonics Ltd.
> >>+ * Author: Stuart Menefy <stuart.menefy@st.com>
> >>+ *
> >>+ * Based on sh_keysc.c, copyright 2008 Magnus Damm
> >Did sh_keysc.c ever exist in Mainline?
> i think no, i 'll suppress "Based on sh_keysc.c, copyright 2008 Magnus Damm"

It is still in here:

[dtor at dtor-d630 work]$ git log --oneline --
drivers/input/keyboard/sh_keysc.c | wc -l
31
[dtor at dtor-d630 work]$

-- 
Dmitry
