From: j@jannau.net (Janne Grunau)
Date: Sun, 30 Aug 2015 17:24:28 +0200
Subject: [arm64/apm] add support for the gigabyte mp30-ar0 board
Message-ID: <1440948270-1991-1-git-send-email-j@jannau.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

following two patches add support for the gigabyte mp30-ar0 mainboard
based on the APM X-Gene Storm (APM883408). The only difference to the
APM88320T used in the mustang board seems to be that it has 4 instead
of 2 DDR memory controllers.

Every device defined in 4.2-rc8's apm-storm.dtsi appears to work.
I haven't tested the 10G ethernet device and the PCIexpress slots.
The second 10G device is missing. It boots only with clk_ignored_unused.
I haven't had a chance to investigate why. The bootloader doesn't clear
x2 and x3.

The board ships with u-boot (U-Boot 2013.04 (Jun 02 2015 - 10:54:10)
REV: 1.15.01-F05), Linux 3.12 and a buildroot based initrd. There seems
no sources available for the shipped binaries. There is no mention of
the GPL in the handbook or shipped materials. The handbook is available
from http://b2b.gigabyte.com/products/product-page.aspx?pid=5422#manual .
The binaries are also available as download from http://b2b.gigabyte.com/products/product-page.aspx?pid=5422#bios .

I asked Thursday for sources of the GPL licensed parts but have of
course no answer yet.

cheers,

Janne


 arch/arm64/boot/dts/apm/Makefile              |  1 +
 arch/arm64/boot/dts/apm/apm-mustang.dts       |  1 +
 arch/arm64/boot/dts/apm/apm-storm-883208.dtsi | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apm/apm-storm-883408.dtsi | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apm/apm-storm.dtsi        | 87 --------------------------------------------
 arch/arm64/boot/dts/apm/mp30ar0.dts           | 85 +++++++++++++++++++++++++++++++++++++++++++
