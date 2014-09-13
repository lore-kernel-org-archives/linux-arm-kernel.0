From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 13 Sep 2014 17:06:13 -0400
Subject: [Patch v2 RfT] ARM: Kirkwood: Fix DT based DSA.
In-Reply-To: <1409592941-22244-1-git-send-email-andrew@lunn.ch>
References: <1409592941-22244-1-git-send-email-andrew@lunn.ch>
Message-ID: <20140913210613.GH30828@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Mon, Sep 01, 2014 at 07:35:41PM +0200, Andrew Lunn wrote:
> During the conversion of boards to use DT to instantiate Distributed
> Switch Architecture, nobody volunteered to test. As to be expected,
> the conversion was flawed. Testers and access to hardware has now
> become available, and this patch hopefully fixes the problems.
> 
> dsa,mii-bus must be a phandle to the top level mdio node, not the port
> specific subnode of the mdio device.
> 
> dsa,ethernet must be a phandle to the port subnode within the ethernet
> DT node, not the ethernet node.
> 
> Don't pinctrl hog the card detect gpio for mvsdio.
> 
> Rename the .dts files to make it clearer which file is for the Z0
> stepping and which for the A0 or later stepping.
> 
> Fixes: e2eaa339af441b3d51cdaa16870065c4154ce13c
> Fixes: e7c8f3808be854379c9784745663a55371cbf232
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Cc: seugene at marvell.com
> ---
> v2:
>   Fix duplex typo
>   Feedback after testing
>   Fix mvsdio card detect gpio
> ---
>  arch/arm/boot/dts/Makefile                         |  4 +-
>  arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts     | 16 +++-----
>  arch/arm/boot/dts/kirkwood-rd88f6281-a.dts         | 43 ++++++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts        | 26 -------------
>  ...-rd88f6281-a1.dts => kirkwood-rd88f6281-z0.dts} | 18 +++++----
>  arch/arm/boot/dts/kirkwood-rd88f6281.dtsi          | 27 +++-----------
>  arch/arm/boot/dts/kirkwood.dtsi                    |  4 +-
>  7 files changed, 69 insertions(+), 69 deletions(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6281-a.dts
>  delete mode 100644 arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts
>  rename arch/arm/boot/dts/{kirkwood-rd88f6281-a1.dts => kirkwood-rd88f6281-z0.dts} (57%)

Applied to mvebu/fixes with Eugene's Tested-by and Cc'd to stable,
v3.15+.

thx,

Jason.
