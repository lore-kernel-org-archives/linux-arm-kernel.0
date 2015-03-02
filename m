From: stefan@agner.ch (Stefan Agner)
Date: Mon, 02 Mar 2015 14:42:01 +0100
Subject: [PATCH] pinctrl: imx: do not implicitly set pin regs to -1
In-Reply-To: <20150302125935.GC7865@pengutronix.de>
References: <1423240256-27210-1-git-send-email-stefan@agner.ch>
 <20150302114516.GC3040@dragon> <20150302125935.GC7865@pengutronix.de>
Message-ID: <43491e2cb2c520d8f15d90ae99a82f28@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-03-02 13:59, Uwe Kleine-K?nig wrote:
> Hello Shawn
> 
> On Mon, Mar 02, 2015 at 07:45:17PM +0800, Shawn Guo wrote:
>> On Fri, Feb 06, 2015 at 05:30:56PM +0100, Stefan Agner wrote:
>> > Commit 3dac1918a491 ("pinctrl: imx: detect uninitialized pins") needs
>> > the values in struct imx_pin_reg to be -1. This has been done in a
>> > rather unorthodox way by setting the memory to 0xff using memset...
>> > Use a proper for loop to initialize the whole array with -1.
>> >
>> > Signed-off-by: Stefan Agner <stefan@agner.ch>
>>
>> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> too late. This patch is part of 4.0-rc1 (4ff0f034e95d).

This is not the same patch. The patch you are mentioning is actually
fixing a bug introduce in the change where we set -1 for uninitialized
pins. This patch is solving the weird assignment of the initial value...

--
Stefan
