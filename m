From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 12:41:16 +0000
Subject: [PATCH 00/19] First HREF Device Tree enablement patch-set
In-Reply-To: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
Message-ID: <201209071241.17198.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, Lee Jones wrote:
> Based on v3.6-rc4
> 
> This patch consists of Device Tree related enablement for
> ST-Ericsson's development HREF hardware reference board.
> Most devices are very similar, if not the same to the
> previously enabled Snowball low-cost development board.
> These are referenced from the relevant .dtsi file and
> merely enabled in the HREF specific Device Tree. There 
> are also one or two minor Device Tree related fixes which
> were stumbled upon along the way.

The patches basically look good to me (except patch 15, see
comment there), but they are not ordered in a way that allows
bisection. I can see two ways to do this better:

a) first do all the code changes, one by one, then add the
fully populated device tree in the last patch.

b) as commented on patch 5, atomically change over each
device in both the DT source and the board code.
Also do the driver changes (i2c, tc3589x) before changing
them in the device tree.

	Arnd
