From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 25 Aug 2016 12:37:46 +0200
Subject: [PATCH 2/2] sdhci-of-arasan: Add quirk and device tree parameter
 to fake CD bit
In-Reply-To: <1472080984-17373-2-git-send-email-zach.brown@ni.com>
References: <1472080984-17373-1-git-send-email-zach.brown@ni.com>
 <1472080984-17373-2-git-send-email-zach.brown@ni.com>
Message-ID: <935c7618-a403-775b-b45c-c3b97e0ed252@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/25/2016 01:23 AM, Zach Brown wrote:
> The sdhci controller on xilinx zynq devices will not function unless
> the cd bit is provided. http://www.xilinx.com/support/answers/61064.html
> In cases where it is impossible to provide the cd bit in hardware,
> setting the controller to test mode and then setting inserted to true
> will get the controller to function with out the cd bit.
> 
> The device property "fake-cd" will let the arasan driver know it needs
> to fake the cd bit for the controller inorder for the controller to
> function with a SD card that does not provide the CD bit.

The devicetree is supposed to be descriptive rather than imperative. fake-cd
is a bit more on the later side. There is already a standard property for
describing that the card-detect pin is not connected, called 'broken-cd'.
Can that be used instead?
