From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 23 Jul 2013 12:37:04 +0100
Subject: [PATCH v4] xen/arm: enable PV control for ARM
In-Reply-To: <5228e08a-1cdb-4240-b10f-9ad690c94ac4@email.android.com>
References: <1374529321-12955-1-git-send-email-julien.grall@linaro.org>
 <5228e08a-1cdb-4240-b10f-9ad690c94ac4@email.android.com>
Message-ID: <alpine.DEB.2.02.1307231235510.4893@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Jul 2013, Konrad Rzeszutek Wilk wrote:
> Julien Grall <julien.grall@linaro.org> wrote:
> >Enable power management from the toolstack for ARM guest.
> >
> >Signed-off-by: Julien Grall <julien.grall@linaro.org>
> >
> >---
> >    Changes in v4:
> >        - Divide the patch in 2 distinct parts
> >    Changes in v3:
> >        - Fix condition to compile cpu_hotplug.o
> >    Changes in v2:
> >        - Don't compile xen/cpu_hotplug.o with ARM64
> >---
> > drivers/xen/Makefile |    3 +--
> > 1 file changed, 1 insertion(+), 2 deletions(-)
> >
> >diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
> >index a609353..f185e8d 100644
> >--- a/drivers/xen/Makefile
> >+++ b/drivers/xen/Makefile
> >@@ -1,9 +1,8 @@
> > ifeq ($(filter y, $(CONFIG_ARM) $(CONFIG_ARM64)),)
> >-obj-y	+= manage.o
> > obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
> > endif
> > obj-$(CONFIG_X86)			+= fallback.o
> >-obj-y	+= grant-table.o features.o events.o balloon.o time.o
> >+obj-y	+= grant-table.o features.o events.o balloon.o time.o manage.o
> > obj-y	+= xenbus/
> > 
> > nostackp := $(call cc-option, -fno-stack-protector)
> 
> The patch looks Ok but the description is off.  Power management is the term used for cpu freq,  C states and P states. While this patch touches none of that. 
> 

That's a very x86-centric view of the world, but it's true that manage.c
is about shutdown, restart and other operations that don't fit under
"power management".
It could benefit from a better description.
