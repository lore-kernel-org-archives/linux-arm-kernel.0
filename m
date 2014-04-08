From: monstr@monstr.eu (Michal Simek)
Date: Tue, 08 Apr 2014 09:03:27 +0200
Subject: [PATCH v2 2/5] ARM: zynq: dt: Convert to preprocessor includes
In-Reply-To: <20140407180228.GN12170@pengutronix.de>
References: <1396653256-28397-1-git-send-email-soren.brinkmann@xilinx.com>
 <1396653256-28397-3-git-send-email-soren.brinkmann@xilinx.com>
 <53423E75.3020008@monstr.eu> <53429754.8080105@topic.nl>
 <534298E7.2020409@monstr.eu> <20140407171012.GC9952@obsidianresearch.com>
 <20140407180228.GN12170@pengutronix.de>
Message-ID: <53439F3F.2030801@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2014 08:02 PM, Steffen Trumtrar wrote:
> Hi!
> 
> On Mon, Apr 07, 2014 at 11:10:12AM -0600, Jason Gunthorpe wrote:
>> On Mon, Apr 07, 2014 at 02:24:07PM +0200, Michal Simek wrote:
>>
>>> Device-tree BSP and in 2014.01 there will be new BSP which just
>>> generate them directly from the Vivado tools which just target your
>>> reference design.  You can connect your custom IP (or Xilinx or 3rd
>>> party) directly to the GIC which using different IRQ sensitivity
>>> with whatever register addresses and make no sense to write it by
>>> hand.
>>
>> On our Zynq design here we ended up being unwilling to use platform
>> generation from Vivado. Basically all our IP was custom, so there was
>> no win at all to invoking the complexity of the automatic tools.
>>
>> Thus we write the DT by hand, and our DT is complex, integrating
>> peripherals that span two FPGAs.
>>
>> I think the in-kernel DT should use the kernel conventions, which
>> means using #include and the binding constants over magic values.
>>
> 
> ACK.
> 
> If in doubt follow common mainline practice. Although using includes
> for DT is not necessarily common practice, readability of DTs is
> really important IMHO.

Let me give you one example. When you add xilinx intc controller
to zynq HW design which uses gic with headers you are using
then you will find out that sensitivity for both controllers
are just different.
This is just one case I am aware of. I expect there will be one more.

Also dtses from kernel are copied to other project because separation
from kernel hasn't be done but there is any plan regarding this.

Using dtc preprocessor and macros improve DTS readability but at the same
time force other users to copy all necessary files from the kernel
to that projects which is just hassle.
With example above there are also cases where using macros is just wrong
that's why I don't want to start to use it.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140408/a9eb5171/attachment-0001.sig>
