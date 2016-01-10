From: tbm@cyrius.com (Martin Michlmayr)
Date: Sat, 9 Jan 2016 20:26:19 -0800
Subject: mvsdio not working on OpenRD
Message-ID: <20160110042619.GA22738@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rick Thomas reported that MMC no longer works on his OpenRD Base.

With Debian's 3.16 kernel (using mach ID):

mvsdio mvsdio: no pins associated
mmc0: host does not support reading read-only switch.  assuming write-enable.
mmc0: new high speed SDHC card at address 0007
mmcblk0: mmc0:0007 SD4GB 3.70 GiB?
 mmcblk0: p1

With Debian's 4.3 and 4.4-rc8 kernels (using Device Tree):

kirkwood-pinctrl f1010000.pin-controller: pin PIN13 already requested by f1012100.serial; cannot claim for f1090000.mvsdio
kirkwood-pinctrl f1010000.pin-controller: pin-13 (f1090000.mvsdio) status -22
kirkwood-pinctrl f1010000.pin-controller: could not request pin 13 (PIN13) from group mpp13  on device f1010000.pin-controller
mvsdio f1090000.mvsdio: Error applying setting, reverse things back
mvsdio f1090000.mvsdio: Got CD GPIO
[and no mmc0 or mmcblk0]

-- 
Martin Michlmayr
http://www.cyrius.com/
