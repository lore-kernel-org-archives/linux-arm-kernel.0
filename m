From: zonque@gmail.com (Daniel Mack)
Date: Thu, 02 Aug 2012 22:17:56 +0200
Subject: [PATCH 1/2] net: davinci_mdio: enable and disable clock
In-Reply-To: <20120802195308.GZ6802@n2100.arm.linux.org.uk>
References: <1343936616-29318-1-git-send-email-zonque@gmail.com>
 <20120802195308.GZ6802@n2100.arm.linux.org.uk>
Message-ID: <501AE074.8090906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.08.2012 21:53, Russell King - ARM Linux wrote:
> On Thu, Aug 02, 2012 at 09:43:35PM +0200, Daniel Mack wrote:
>> Make the driver control the device clocks. Appearantly, the Davinci
>> platform probes this driver with the clock all powered up, but on OMAP,
>> this isn't the case.
> 
> Hmm, this looks like it could do with improvement, especially as we're
> moving everything over to a common clk API.
> 
> 1. This driver could do with clk_prepare()/clk_unprepare() calls.

Ok, done.

> 2. This driver should not be making the assumption that NULL means
>    it can avoid clk_* calls.  It should instead be using
> 	if (!IS_ERR(clk))

Well spotted. Amended patch below.


Thanks,
Daniel



-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-net-davinci_mdio-prepare-and-unprepare-clocks.patch
Type: text/x-patch
Size: 2045 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120802/2fa5d4e5/attachment.bin>
