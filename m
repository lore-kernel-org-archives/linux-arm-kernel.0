From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 25 Aug 2016 08:10:47 -0700
Subject: [PATCH 1/2] sdhci-of-arasan: Add quirk and device tree parameter
 to fake CD bit
In-Reply-To: <1472080984-17373-1-git-send-email-zach.brown@ni.com>
References: <1472080984-17373-1-git-send-email-zach.brown@ni.com>
Message-ID: <20160825151047.GO16583@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-08-24 at 18:23:03 -0500, Zach Brown wrote:
> The sdhci controller on xilinx zynq devices will not function unless
> the cd bit is provided. http://www.xilinx.com/support/answers/61064.html
> In cases where it is impossible to provide the cd bit in hardware,
> setting the controller to test mode and then setting inserted to true
> will get the controller to function with out the cd bit.
> 
> The device property "fake-cd" will let the arasan driver know it needs
> to fake the cd bit for the controller inorder for the controller to
> function with a SD card that does not provide the CD bit.

I thought the CD is, if not pinned out, tied off to some valid logic
level. Isn't it enough to specify cd-inverted if needed to make it work
in those cases?

	S?ren
