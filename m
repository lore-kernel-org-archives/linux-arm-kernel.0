From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 25 Mar 2014 09:21:07 -0400
Subject: [PATCH] arm: boot: dts: build keystone devicetree blob
In-Reply-To: <20140321144328.GC12310@saruman.home>
References: <1394639330-1288-1-git-send-email-balbi@ti.com>
 <53208CDD.7030106@ti.com> <532C4F40.5010903@ti.com>
 <20140321144328.GC12310@saruman.home>
Message-ID: <533182C3.9060708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 March 2014 10:43 AM, Felipe Balbi wrote:
> On Fri, Mar 21, 2014 at 10:40:00AM -0400, Santosh Shilimkar wrote:
>> On Wednesday 12 March 2014 12:35 PM, Santosh Shilimkar wrote:
>>> On Wednesday 12 March 2014 11:48 PM, Felipe Balbi wrote:
>>>> Currently, even when building keystone only
>>>> kernel builds, DTB won't get build because
>>>> we lack a Makefile rule to get it compiled.
>>>>
>>>> This patch adds that rule so mainline kernel
>>>> users have a chance to use up-to-date DTB on
>>>> keystone 2 platforms.
>>>>
>>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>>>> ---
>>>>
>>> We have been building dtbs with explicit command
>>> instead of dtbs since it was just one dtb so far
>>> supported. Was planning to add the rule once more
>>> boards get added. Now with Lamarr and Edision in
>>> for next merge window, will do that post 3.15-rc1.
>>>
>> Just to close the loop, I added a patch as part
>> of my 3.15 fixes which builds all keystone dt
>> blobs.
> 
> cool, thanks
> 
Here is the updated patch which I commited to fixes branch.
Sorry to miss your reported-by tag. I just missed it.

>From 400550ae7e778302a45d2952ac75907903e2610c Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Tue, 18 Mar 2014 16:02:34 -0400
Subject: [PATCH] ARM: dts: Build all keystone dt blobs

Now we have additional two SOC/boards supported, so add
make file rule so that all device tree blobs can be build
for keystone with 'make dtbs'.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/Makefile |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b9d6a8b..49ff796 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -81,6 +81,9 @@ dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
 	ecx-2000.dtb
 dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
 	integratorcp.dtb
+dtb-$(CONFIG_ARCH_KEYSTONE) += k2hk-evm.dtb \
+	k2l-evm.dtb \
+	k2e-evm.dtb
 dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
 dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
 	kirkwood-db-88f6281.dtb \
-- 
1.7.9.5
