From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 Dec 2017 16:05:02 -0200
Subject: [PATCH] ARM: dts: imx: Add memory node unit name
In-Reply-To: <1512575989-15627-1-git-send-email-marcofrk@gmail.com>
References: <1512575989-15627-1-git-send-email-marcofrk@gmail.com>
Message-ID: <CAOMZO5DSgY18PNtkPq3eTCKNV63PUP3PT3cojzz1e2wkkoG1Xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 6, 2017 at 1:59 PM, Marco Franchi <marcofrk@gmail.com> wrote:
> Fix the following warnings from dtc by adding the unit name to memory
> nodes:
>
> Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
>
> Converted using the following command:
>
> perl -p0777i -e 's/memory \{\n\t\treg = \<0x+([0-9a-f])/memory\@$1$\0000000 \{\n\t\treg = <0x$1/m' `find ./arch/arm/boot/dts -name "imx*"`
>
> The files below were manually fixed:
> -imx1-ads.dts
> -imx1-apf9328.dts
>
> Signed-off-by: Marco Franchi <marcofrk@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
