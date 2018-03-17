From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Sat, 17 Mar 2018 13:49:12 +0300
Subject: SPI driver issue
Message-ID: <99bf058c-d15e-390b-7723-fca15770c118@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

I have recently found a critical issue with sun6i SPI driver. It was 
actually found long time ago while using spidev but I didn't considered 
it as something important. Now it seems like a blocking issue that 
prevents using the driver in any serious application.
I have created a DRM driver for a ili9488-based display, its source is 
available here [1] and device tree overlay [2]. The driver has been 
successfully verified on RPi3, but? it is failing on sunxi: the driver 
gets loaded, display seems working but SPI transfers are periodically 
failing with error -110 (timeout). Due to the issue the picture is 
frozen and completely refreshed again from time to time.

The problem is reproduced on OrangePi PC and BananaPi M2. I am providing 
dmesg from my OrangePi PC [3].

Let know if you need any additional info.

Thanks

-------------------------------------------------------------------

[1] https://github.com/sergey-suloev/tinydrm/blob/master/ili9488.c

[2] 
https://github.com/sergey-suloev/tinydrm/blob/master/overlays/sunxi/mainline/sun8i-h3-ertft0356-drm.dts

[3] https://pastebin.com/xYqWKcJ2
