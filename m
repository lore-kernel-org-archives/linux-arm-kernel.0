From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 18 Oct 2013 16:59:20 +0200 (CEST)
Subject: [BUILD BROKEN] Current Linus' master and -next don't build for
 imx_v6_v7_defconfig
Message-ID: <Pine.LNX.4.64.1310181632160.9158@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all

On current Linus' tree as of 04919af as well as -next since 16.10, IIRC, 
compilation is broken for i.MX3*, including the default 
imx_v6_v7_defconfig. The toolchain used is

arm-none-linux-gnueabi-gcc (Sourcery CodeBench Lite 2012.09-64) 4.7.2

and here's the log (path stripped for readability)

arch/arm/lib/copy_template.S: Assembler messages:
arch/arm/lib/copy_template.S:100: Error: selected processor does not support ARM mode `ldralt r3,[r1],#4'
arch/arm/lib/copy_template.S:100: Error: selected processor does not support ARM mode `ldralt r4,[r1],#4'
arch/arm/lib/copy_template.S:100: Error: selected processor does not support ARM mode `ldralt r5,[r1],#4'
arch/arm/lib/copy_template.S:100: Error: selected processor does not support ARM mode `ldralt r6,[r1],#4'
arch/arm/lib/copy_template.S:100: Error: selected processor does not support ARM mode `ldralt r7,[r1],#4'
arch/arm/lib/copy_template.S:100: Error: selected processor does not support ARM mode `ldralt r8,[r1],#4'
arch/arm/lib/copy_template.S:100: Error: selected processor does not support ARM mode `ldralt ip,[r1],#4'
arch/arm/lib/copy_template.S:100: Error: selected processor does not support ARM mode `ldralt lr,[r1],#4'
arch/arm/lib/copy_template.S:118: Error: selected processor does not support ARM mode `ldralt r3,[r1],#4'
arch/arm/lib/copy_template.S:119: Error: selected processor does not support ARM mode `ldralt r4,[r1],#4'
arch/arm/lib/copy_template.S:120: Error: selected processor does not support ARM mode `ldralt r5,[r1],#4'
arch/arm/lib/copy_template.S:121: Error: selected processor does not support ARM mode `ldralt r6,[r1],#4'
arch/arm/lib/copy_template.S:122: Error: selected processor does not support ARM mode `ldralt r7,[r1],#4'
arch/arm/lib/copy_template.S:123: Error: selected processor does not support ARM mode `ldralt r8,[r1],#4'
arch/arm/lib/copy_template.S:124: Error: selected processor does not support ARM mode `ldralt lr,[r1],#4'
arch/arm/lib/copy_template.S:173: Error: selected processor does not support ARM mode `ldralt lr,[r1],#4'
arch/arm/lib/copy_template.S:243: Error: selected processor does not support ARM mode `ldralt r4,[r1],#4'
arch/arm/lib/copy_template.S:243: Error: selected processor does not support ARM mode `ldralt r5,[r1],#4'
arch/arm/lib/copy_template.S:243: Error: selected processor does not support ARM mode `ldralt r6,[r1],#4'
arch/arm/lib/copy_template.S:243: Error: selected processor does not support ARM mode `ldralt r7,[r1],#4'
arch/arm/lib/copy_template.S:243: Error: selected processor does not support ARM mode `ldralt r8,[r1],#4'
arch/arm/lib/copy_template.S:243: Error: selected processor does not support ARM mode `ldralt r9,[r1],#4'
arch/arm/lib/copy_template.S:243: Error: selected processor does not support ARM mode `ldralt ip,[r1],#4'
arch/arm/lib/copy_template.S:243: Error: selected processor does not support ARM mode `ldralt lr,[r1],#4'
arch/arm/lib/copy_template.S:243: Error: selected processor does not support ARM mode `ldralt lr,[r1],#4'
arch/arm/lib/copy_template.S:245: Error: selected processor does not support ARM mode `ldralt r4,[r1],#4'
arch/arm/lib/copy_template.S:245: Error: selected processor does not support ARM mode `ldralt r5,[r1],#4'
arch/arm/lib/copy_template.S:245: Error: selected processor does not support ARM mode `ldralt r6,[r1],#4'
arch/arm/lib/copy_template.S:245: Error: selected processor does not support ARM mode `ldralt r7,[r1],#4'
arch/arm/lib/copy_template.S:245: Error: selected processor does not support ARM mode `ldralt r8,[r1],#4'
arch/arm/lib/copy_template.S:245: Error: selected processor does not support ARM mode `ldralt r9,[r1],#4'
arch/arm/lib/copy_template.S:245: Error: selected processor does not support ARM mode `ldralt ip,[r1],#4'
arch/arm/lib/copy_template.S:245: Error: selected processor does not support ARM mode `ldralt lr,[r1],#4'
arch/arm/lib/copy_template.S:245: Error: selected processor does not support ARM mode `ldralt lr,[r1],#4'
arch/arm/lib/copy_template.S:247: Error: selected processor does not support ARM mode `ldralt r4,[r1],#4'
arch/arm/lib/copy_template.S:247: Error: selected processor does not support ARM mode `ldralt r5,[r1],#4'
arch/arm/lib/copy_template.S:247: Error: selected processor does not support ARM mode `ldralt r6,[r1],#4'
arch/arm/lib/copy_template.S:247: Error: selected processor does not support ARM mode `ldralt r7,[r1],#4'
arch/arm/lib/copy_template.S:247: Error: selected processor does not support ARM mode `ldralt r8,[r1],#4'
arch/arm/lib/copy_template.S:247: Error: selected processor does not support ARM mode `ldralt r9,[r1],#4'
arch/arm/lib/copy_template.S:247: Error: selected processor does not support ARM mode `ldralt ip,[r1],#4'
arch/arm/lib/copy_template.S:247: Error: selected processor does not support ARM mode `ldralt lr,[r1],#4'
arch/arm/lib/copy_template.S:247: Error: selected processor does not support ARM mode `ldralt lr,[r1],#4'
make[2]: *** [arch/arm/lib/copy_from_user.o] Error 1
make[1]: *** [arch/arm/lib] Error 2
make[1]: *** Waiting for unfinished jobs....

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
