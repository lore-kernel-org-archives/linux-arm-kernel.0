From: monstr@monstr.eu (Michal Simek)
Date: Mon, 07 Apr 2014 14:24:07 +0200
Subject: [PATCH v2 2/5] ARM: zynq: dt: Convert to preprocessor includes
In-Reply-To: <53429754.8080105@topic.nl>
References: <1396653256-28397-1-git-send-email-soren.brinkmann@xilinx.com>
 <1396653256-28397-3-git-send-email-soren.brinkmann@xilinx.com>
 <53423E75.3020008@monstr.eu> <53429754.8080105@topic.nl>
Message-ID: <534298E7.2020409@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 04/07/2014 02:17 PM, Mike Looijmans wrote:
> On 04/07/2014 07:58 AM, Michal Simek wrote:
>> Hi Soren,
>>
>> On 04/05/2014 01:14 AM, Soren Brinkmann wrote:
>>> Convert all Zynq DT files to the dtc preprocessor include syntax.
>>> This allows to include header files in the devicetrees like other
>>> SoC-types already do.
>>>
>>> Inspired-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>>> (http://www.spinics.net/lists/arm-kernel/msg319832.html)
>>>
>>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>>
>> These 4 patches needs more wider discussion if this is helpful or
>> not. Currently I can't see any value in it because everything
>> is just generated and fixed. I think I had the same discussion
>> with Laurent some weeks ago regarding this.
> 
> I would be kinda neutral here. I'd consider it helpful, it improves readability (regardless of whether they 
are generated or hand crafted). That's convenient for things like interrupt sensitivity,
I can't remember whether 4 is level or edge type. On the other hand, the clock indices are just
 as much magic numbers as the memory addresses. If I suspect an error in that area, I'd start by lokking
in /sys/kernel/debug/clk but wouldn't start in the DT.
> 
>> IRC the origin idea to use this was especially for people who
>> writing these DTS by hand which is not our case - at least
>> for majority of our customers.
> 
> I write them by hand. Is there any other way?

Device-tree BSP and in 2014.01 there will be new BSP which just generate
them directly from the Vivado tools which just target your reference design.
You can connect your custom IP (or Xilinx or 3rd party) directly to the GIC
which using different IRQ sensitivity with whatever register addresses
and make no sense to write it by hand.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140407/2bfe0317/attachment.sig>
