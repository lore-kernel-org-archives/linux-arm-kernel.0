From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 7 Sep 2014 09:38:51 +0200
Subject: [PATCH 1/2] ARM: mvebu: Netgear RN104: Use Hardware BCH ECC
In-Reply-To: <920c7e7169dc6aaaa3eb4bced2336d38e77b8864.1410035142.git.arno@natisbad.org>
References: <cover.1410035142.git.arno@natisbad.org>
 <920c7e7169dc6aaaa3eb4bced2336d38e77b8864.1410035142.git.arno@natisbad.org>
Message-ID: <20140907093851.377ddd29@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnaud Ebalard,

On Sat, 06 Sep 2014 22:49:25 +0200, Arnaud Ebalard wrote:

> Fixes: 0373a558bd79 ("ARM: mvebu: Enable NAND controller in ReadyNAS 104 .dts file")
> Depends-on: 5b3e507820c6 ("mtd: nand: pxa3xx: Use ECC strength and step size devicetree binding")

Maybe it's worth noting that it's not a build dependency: your commit
changing the Device Tree files can perfectly be applied without the
NAND ECC strength and step size bindings. Of course, it will have no
effect on an older kernel that doesn't support those bindings, but it
will not cause a build failure.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
