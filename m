From: ijc@hellion.org.uk (Ian Campbell)
Date: Wed, 08 Jan 2014 16:55:37 +0000
Subject: [linux-sunxi] [ANNOUNCE] sunxi-babelfish (FEX-to-DT translator)
In-Reply-To: <20140107220310.GD3103@lukather>
References: <20140107220310.GD3103@lukather>
Message-ID: <1389200137.27473.6.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-01-07 at 23:03 +0100, Maxime Ripard wrote:

> Hence why I started to work on sunxi-babelfish. It aims at being a
> very thin wrapper around the kernel image, that would generate an
> uImage, with the babelfish code itself, plus the compiled DTSI we have
> for the targetted SoCs, and finally the kernel image. During bootup,
> babelfish will take one of these DTBs, and complete it using the
> informations fetched from the compiled FEX file the board is feeding
> it, before finally passing the DTB to Linux that will continue its
> usual boot.

Very cool!

> [...]
> Another nice thing about it is that a FEX-to-DT compiler comes at no
> cost afterwards. Since dtc is able to generate a DTS from
> /proc/device-tree, you can easily generate a DTS for your previously
> non-supported board using
> 
>   dtc -I fs -O dts -o my-board.dts /proc/device-tree/

I wonder if it might also be useful to compile this as a normal user
space application which takes the fex and produces the dtb (or dts)?

I suppose producing something upstreamable would be different/harder
though, since it would need to not inline/merge the dtsi file but just
leave the include stmt. That's probably a different tool.

Ian.
