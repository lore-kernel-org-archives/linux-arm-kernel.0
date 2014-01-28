From: monstr@monstr.eu (Michal Simek)
Date: Tue, 28 Jan 2014 14:54:32 +0100
Subject: [Q] block / zynq: DMA bouncing
In-Reply-To: <20140128134827.GK15937@n2100.arm.linux.org.uk>
References: <Pine.LNX.4.64.1401271549280.23931@axis700.grange>
 <20140127170230.GQ15937@n2100.arm.linux.org.uk> <52E69B4E.5010604@monstr.eu>
 <20140127175231.GU15937@n2100.arm.linux.org.uk> <52E69E1E.3020202@monstr.eu>
 <Pine.LNX.4.64.1401281420580.2714@axis700.grange>
 <20140128134827.GK15937@n2100.arm.linux.org.uk>
Message-ID: <52E7B698.60401@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2014 02:48 PM, Russell King - ARM Linux wrote:
> On Tue, Jan 28, 2014 at 02:28:28PM +0100, Guennadi Liakhovetski wrote:
>> +static void __init zynq_memory_init(void)
>> +{
>> +	/*
>> +	 * Reserve the 0-0x4000 addresses (before page tables and kernel)
>> +	 * which can't be used for DMA
>> +	 */
>> +	if (!__pa(PAGE_OFFSET))
>> +		memblock_reserve(0, 0x4000);
> 
> Or maybe this:
> 
> 	memblock_reserve(__pa(PAGE_OFFSET), __pa(swapper_pg_dir));
> 
> since that's actually what you mean here.

yep with that if too.

I will prepare that patch and will send it out.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140128/a500c3b6/attachment.sig>
