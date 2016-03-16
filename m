From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Wed, 16 Mar 2016 08:43:10 -0700
Subject: [PATCH] ARM: dts: k2*: Rename the k2* files to keystone-k2* files
In-Reply-To: <1458139150-30382-1-git-send-email-nm@ti.com>
References: <1458139150-30382-1-git-send-email-nm@ti.com>
Message-ID: <56E97F0E.6070309@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/16/2016 7:39 AM, Nishanth Menon wrote:
> As reported in [1], rename the k2* dts files to keystone-* files
> this will force consistency throughout.
>
> Script for the same (and hand modified for Makefile and MAINTAINERS
> files):
> for i in arch/arm/boot/dts/k2*
> do
> 	b=`basename $i`;
> 	git mv $i arch/arm/boot/dts/keystone-$b;
> 	sed -i -e "s/$b/keystone-$b/g" arch/arm/boot/dts/*[si]
> done
>
> NOTE: bootloaders that depend on older dtb names will need to be
> updated as well.
>
> [1] http://marc.info/?l=linux-arm-kernel&m=145637407804754&w=2
>
> Reported-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>
Thanks Nishant for taking care of this. I will add this to the
next soon.

Reagrds,
Santosh
