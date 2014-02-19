From: monstr@monstr.eu (Michal Simek)
Date: Wed, 19 Feb 2014 14:51:36 +0100
Subject: [RFC PATCH v2 1/2] mfd: syscon: Support early initialization
In-Reply-To: <20140219121756.GM2669@sirena.org.uk>
References: <cover.1392807832.git.michal.simek@xilinx.com>
 <fa3178534fcf4488fc45a9a24e44b2588acb38c6.1392807832.git.michal.simek@xilinx.com>
 <20140219114132.GC10504@lee--X1> <53049932.8020901@monstr.eu>
 <20140219121756.GM2669@sirena.org.uk>
Message-ID: <5304B6E8.1090508@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2014 01:17 PM, Mark Brown wrote:
> On Wed, Feb 19, 2014 at 12:44:50PM +0100, Michal Simek wrote:
>> On 02/19/2014 12:41 PM, Lee Jones wrote:
> 
>>> I believe you were waiting for Arnd and/or Mark to comment.
> 
>> yes on Arnd because Mark already applied that regmap part.
>> But of course any input how to get this done will be helpful.
> 
> Like I said I've never seen the user you're adding for the regmap API so
> I've no particular opinion on it.

2/2 is the code where I would like to use this when clk subsystem
start to use better io helper functions then just static inline
clk_readl/clk_writel.

Then my 2/2 driver will be just nicer than current implementation.

Regarding syscon changes. I think the right question is if this driver
should be still in drivers/mfd/ or should be moved to somewhere else
(drivers/base for example).

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140219/05fbfdcf/attachment.sig>
