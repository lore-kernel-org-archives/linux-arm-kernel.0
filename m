From: monstr@monstr.eu (Michal Simek)
Date: Thu, 10 Apr 2014 12:44:20 +0200
Subject: [PATCH v2 2/5] ARM: zynq: dt: Convert to preprocessor includes
In-Reply-To: <20140408172752.GC27776@obsidianresearch.com>
References: <1396653256-28397-1-git-send-email-soren.brinkmann@xilinx.com>
 <1396653256-28397-3-git-send-email-soren.brinkmann@xilinx.com>
 <53423E75.3020008@monstr.eu> <53429754.8080105@topic.nl>
 <534298E7.2020409@monstr.eu> <20140407171012.GC9952@obsidianresearch.com>
 <20140407180228.GN12170@pengutronix.de> <53439F3F.2030801@monstr.eu>
 <20140408172752.GC27776@obsidianresearch.com>
Message-ID: <53467604.1020400@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2014 07:27 PM, Jason Gunthorpe wrote:
> On Tue, Apr 08, 2014 at 09:03:27AM +0200, Michal Simek wrote:
> 
>>> If in doubt follow common mainline practice. Although using includes
>>> for DT is not necessarily common practice, readability of DTs is
>>> really important IMHO.
>>
>> Let me give you one example. When you add xilinx intc controller
>> to zynq HW design which uses gic with headers you are using
>> then you will find out that sensitivity for both controllers
>> are just different.
>> This is just one case I am aware of. I expect there will be one more.
> 
> I'm not sure I see the problem here, just because some bindings can't
> use the standard shared constants doesn't mean the GIC bindings and
> users should avoid them. The binding documentation is supposed to make
> it clear what is correct.
> 
> It is just as easy to get confused with numbers, does 4 mean
> XILINX_INTC_IRQ_RISING or IRQ_TYPE_LEVEL_HIGH ?

That's why you have there biding documentation to exactly know what it is.

>> Using dtc preprocessor and macros improve DTS readability but at the same
>> time force other users to copy all necessary files from the kernel
>> to that projects which is just hassle.
> 
> You can run the DTS through cpp before you export it out of the kernel
> environment, then you get a flat file with no includes.

What's the result?
1. DTSI and DTS together which completely break hierarchy
2. DTS without comments

It means, yes, you get a file when you go through cpp but different
then you have now.

> The shared kernel conventions are more important than constraints from
> outside projects.

zynq-7000.dtsi is fixed and you can't just change it based on your project.
For things which are in your board file like zynq-zc702 then you can use
whatever you like.

Maybe I just need some time to get used to it but currently...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140410/36cce1d5/attachment.sig>
