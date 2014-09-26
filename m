From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 26 Sep 2014 10:57:54 +0800
Subject: linux-next: build failure after merge of the arm-soc tree
In-Reply-To: <20140926115539.6873630b@canb.auug.org.au>
References: <20140926115539.6873630b@canb.auug.org.au>
Message-ID: <5424D632.4000004@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2014/9/26 9:55, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the arm-soc tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> Error: arch/arm/boot/dts/hisi-x5hd2.dtsi:374.22-23 syntax error
> FATAL ERROR: Unable to parse input tree
> 
> There are a series of new commits to this file today and I have no idea
> which one caused the problem.

Hi Stephen,

Sorry for that.
It is caused by this commit: 610bd8722ef4 "ARM: dts: hix5hd2: add wdg node".
And Olof has already helped to reverted this commit.

Best Regards,
Wei

> I reverted:
> 
> 610bd8722ef4	"ARM: dts: hix5hd2: add wdg node"
> 6868feb6dd97	"ARM: dts: hix5hd2: add gpio node"
> 420a2d55f046	"ARM: dts: hix5hd2: add sata node"
> f16c7fb2f3ff	"ARM: dts: hix5hd2: add usb node"
> b196e1ca400d	"ARM: dts: hix5hd2: add mmc node"
> de8b6054780e	"ARM: dts: hix5hd2: add gmac node"
> 
> which fixed the build problem.
> 
