From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 2 May 2011 17:52:25 +0200
Subject: [RFC PATCH 4/4] ARM: Xilinx: Adding Xilinx board support
In-Reply-To: <4DBEB1A8.3040202@gmail.com>
References: <20110502045207.24800.91172.stgit@ponder>
	<201105021039.32374.arnd@arndb.de> <4DBEB1A8.3040202@gmail.com>
Message-ID: <201105021752.25273.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 May 2011, Rob Herring wrote:
> The SCU is accessed before ioremap is up. The only reason it is accessed 
> early is to determine the number of cores present.

The number of cores should definitely be available in the device tree,
normally by looking at the root interrupt controller.

> The L2 can certainly be ioremapped and probed via DT. How about 
> something like this:
> 
>         l2cc {
>                 compatible = "arm,pl310-l2";
>                 reg = <0xfff12000 0x1000>;
>                 aux-value = <0>;
>                 aux-mask = <0xffffffff>;
>         };

sounds good to me.

	Arnd
