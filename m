From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Fri, 08 Aug 2014 15:02:03 -0700
Subject: [BUG]: imx6q (wandboard): Very unstable ethernet since kernel 3.16
In-Reply-To: <1407509932.19455.7.camel@sharkbay.at>
References: <1407503758.19455.1.camel@sharkbay.at>
 <20140808132754.GC30282@n2100.arm.linux.org.uk>
 <1407507023.19455.3.camel@sharkbay.at>
 <20140808143008.GD30282@n2100.arm.linux.org.uk>
 <1407509932.19455.7.camel@sharkbay.at>
Message-ID: <53E548DB.90905@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/8/2014 7:58 AM, Thomas Scheiblauer wrote:
> 
> 
> Indeed, commenting out these 2 lines in
> arch/arm/boot/dts/imx6qdl-wandboard.dtsi fixes my problem without having
> to increase TX_RING_SIZE.
> Thank you very much!
> 
Could you also please checkout commit

commit 9fc77821b17155c6e0ab50b1e1dd80c2b0e63e98
Author: Sascha Silbe <x-linux@infra-silbe.de>
Date:   Thu Feb 6 23:24:13 2014 +0100

    ARM: dts: imx6qdl-wandboard: use GPIO_6 for FEC interrupt


and see if it also shows ethernet instabilities?


Thanks
Troy
