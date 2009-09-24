From: dave@chronolytics.com (David F. Carlson)
Date: Thu, 24 Sep 2009 13:42:20 -0400 (EDT)
Subject: Announcing s3c64xx XWindows fbdrv w/ XAA+XVideo+HWcursor
Message-ID: <200909241742.n8OHgLHr004520@chronolytics.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


S3C6410 based Xwindows fbdev with
   o  XAA accelerated fills, lines, expands, blits, offscreen pixmaps/stipples
   o  Alpha-blended HWCursor 
   o  XVideo Support (using the Samsung Post-Processor colorspace driver)
   o  Tested with the Maemo Mer kernel 2.6.24.7 because...

This is not as off topic as it might seem...

The XWindows subsystem needs help from the kernel in s3cfb "standards" 
(support MMIO interface) and configuration (how to configure per-screen 
offscreen memory), some scheme for accessing the Post-Processor and G2D 
graphics support.  (And of course, gaining driver support for pp and g2d 
including suspend/resume.)

This driver is pretty much hardcoded for s3c64xx.  If kernel hooks for 
describing configuration this driver base could be expanded to 
support many s3c variants (with g2d and pp).

There is some discussion in the the README.

http://chronolytics.com/mid/README
http://chronolytics.com/mid/fbdev_xaa_pp_hwcurs.tgz

Acknowledgements:

The most excellent XAA base code was done by 
   Matan Ziv-Av <matan@svgalib dot org>

The original XVideo code was done by 
   Jetta Tang <jetta.tang@hhcn dot com>

The g2d and pp drivers upon which this code is based were provided by
   Samsung Semiconductor.  Thanks.

Time and Materials and Hosting 
   Chronolytics Inc.  Real-Time Embedded Software  http://chronolytics.com

David F. Carlson    Chronolytics, Inc.  Rochester, NY
mailto:dave at chronolytics.com            http://www.chronolytics.com

"The faster I go, the behinder I get." --Lewis Carroll
