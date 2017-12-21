From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 21 Dec 2017 09:07:36 +0100
Subject: [PATCH] ARM: dts: imx: Add memory node unit name
In-Reply-To: <1512575989-15627-1-git-send-email-marcofrk@gmail.com>
References: <1512575989-15627-1-git-send-email-marcofrk@gmail.com>
Message-ID: <20171221090736.3ac9d5db@karo-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed,  6 Dec 2017 13:59:49 -0200 Marco Franchi wrote:
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
The imx*.dtsi files all have this:
|	memory { device_type = "memory"; reg = <0 0>; };
Thus you will end up with a 'memory' node with a reg = <0 0> entry and
an additional 'memory at ...' node with the correct 'reg' values.


Lothar Wa?mann
