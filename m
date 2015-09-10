From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Thu, 10 Sep 2015 12:25:32 +0200
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <20150908125756.GY21084@n2100.arm.linux.org.uk> (Russell King's
 message of "Tue, 8 Sep 2015 13:57:56 +0100")
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m37fo25nrl.fsf@t19.piap.pl>
 <20150908091625.GV21084@n2100.arm.linux.org.uk>
 <m3y4gh41k4.fsf@t19.piap.pl>
 <20150908125756.GY21084@n2100.arm.linux.org.uk>
Message-ID: <m3a8su4llv.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now I'm trying to use the imxdrm Xv output.

$ mplayer -vo xv test.mp4 -x 720

VO Config (720x576->720x576,flags=0,'MPlayer',0x32315659)
VO: [xv] 720x576 => 720x576 Planar YV12
Xvideo image format: 0x34325241 (AR24) packed
Xvideo image format: 0x34325258 (XR24) packed
Xvideo image format: 0x34324241 (AB24) packed
Xvideo image format: 0x34324258 (XB24) packed
Xvideo image format: 0x32595559 (YUY2) packed
Xvideo image format: 0x30323449 (I420) planar
Xvideo image format: 0x32315659 (YV12) planar
Xvideo image format: 0x4f425658 (XVBO) planar
using Xvideo port 85 for hw scaling
*** [vo] Exporting mp_image_t, 720x576x12bpp YUV planar, 622080 bytes

Adaptor #0: "Marvell Armada Overlay Video"
number of ports: 1
port base: 85

The Y plane is ok, but the Xv window is green, like on old monochrome
CRTs - what could that be? It looks like the UV planes are all wrong.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
