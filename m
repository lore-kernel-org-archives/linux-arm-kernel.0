From: todorcolov@abv.bg (Todor Colov)
Date: Sat, 9 Jun 2012 15:37:14 +0300 (EEST)
Subject: ARM/CIRRUS LOGIC EP93XX ARM ARCHITECTURE - patch proposal: for ep9302
 i2c support is not enabled in kernel - submit patch to enable it & merge it
 in the newer kernels
Message-ID: <1621975213.53747.1339245434729.JavaMail.apache@nm41.abv.bg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dear all, 

I'm contacting you as your are the offical maintainers of "ARM/CIRRUS LOGIC EP93XX ARM ARCHITECTURE " 


For ep9302 sub-architecture "i2c" support is not enabled in the recet kernels. i2c support is needed when external RTC are used. 


 

Here you can find possibe patch to enable it ( also attached ): Please validate it and submit it for merge in the newer kernels: 

[root at FC9 linux-3.4]# diff -u arch/arm/mach-ep93xx/edb93xx.c arch/arm/mach-ep93xx/edb93xx-i2c-ep9302-enabled.c
--- arch/arm/mach-ep93xx/edb93xx.c




 2012-05-21 01:29:13.000000000 +0300
+++ arch/arm/mach-ep93xx/edb93xx-i2c-ep9302-enabled.c

 2012-06-09 15:24:23.217996476 +0300
@@ -91,7 +91,7 @@















 ep93xx_register_i2c(&amp;edb93xx_i2c_gpio_data,



































 edb93xxa_i2c_board_info,



































 ARRAY_SIZE(edb93xxa_i2c_board_info));
-





 } else if (machine_is_edb9307() || machine_is_edb9312() ||
+





 } else if (  machine_is_edb9302()   || machine_is_edb9307() || machine_is_edb9312() ||


















 machine_is_edb9315()) {















 ep93xx_register_i2c(&amp;edb93xx_i2c_gpio_data,



































 edb93xx_i2c_board_info,
 

Thanks, 

Todor Colov 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120609/6ff216ac/attachment.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: edb93xx-i2c-ep9302-enable.patch
Type: application/octet-stream
Size: 563 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120609/6ff216ac/attachment.obj>
