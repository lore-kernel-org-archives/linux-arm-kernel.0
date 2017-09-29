From: linus.luessing@c0d3.blue (Linus =?utf-8?Q?L=C3=BCssing?=)
Date: Fri, 29 Sep 2017 13:29:59 +0200
Subject: [PATCH v7 6/6] ARM: dts: meson8b: add support for booting the
 secondary CPU cores
In-Reply-To: <20170917164523.6970-7-martin.blumenstingl@googlemail.com>
Message-ID: <20170929112959.GM6726@otheros>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A five hours test run with the stress-ng tool worked fine for this
patchset for me.

stress-ng command:
$ stress-ng -v --sequential 0 -t 120s --exclude sysfs,opcode --metrics

Logfile (6.3MB):
http://metameute.de/~tux/linux/amlogic/stress-ng-odroidc1%2b-with-resmem%2bsmp-log.txt

Tested device:
- Odroid C1+

Tested OS:
- Debian stable (stress-ng 0.07.16)

Tested kernel: v4.14-rc1 plus this patchset plus:
- "ARM: dts: meson: fixing USB support on Meson6, Meson8 and Meson8b"
  https://patchwork.kernel.org/patch/9965871/
- "ARM: dts: meson: enabling the USB Host controller on Odroid-C1/C1+ board"
  https://patchwork.kernel.org/patch/9961565/
- "[RFC] ARM: dts: meson8b: add reserved memory zones"
  https://patchwork.kernel.org/patch/9977479/

Tested kernel config:
- multi_v7_defconfig, except CONFIG_DRM_TEGRA=n (build error otherwise)

 
I had to exclude the sysfs and opcode tests though. The former
created an unhandled kernel paging request. And the latter a
silent freeze after some seconds.

Those two issues seem unrelated to this patchset though,
therefore

Tested-by: Linus L?ssing <linus.luessing@c0d3.blue>
