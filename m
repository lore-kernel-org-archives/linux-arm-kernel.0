From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 11 Feb 2015 15:25:02 +0100
Subject: [PATCH 2/2] ARM: dts: zynq: Add linux, stdout-path and stdout-path
In-Reply-To: <20150211124027.GH9154@leverpostej>
References: <0a0e0579fb6e2794d2c0c6fb9186c5b43618f448.1423657710.git.michal.simek@xilinx.com>
 <ea777ffbffea442e3bc69fe11183811772a5716e.1423657710.git.michal.simek@xilinx.com>
 <20150211124027.GH9154@leverpostej>
Message-ID: <74a9cc5d88d64421a4f1ebdacee93d7d@BL2FFO11FD041.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2015 01:40 PM, Mark Rutland wrote:
> On Wed, Feb 11, 2015 at 12:29:02PM +0000, Michal Simek wrote:
>> parallella - Use reference instead of hardcoded path
>>              (linux,stdout-path)
>>
>> stdout-path is used by bootloader to identify console.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> U-Boot driver model requires stdout-path.
>> ---
>>  arch/arm/boot/dts/zynq-parallella.dts | 3 ++-
>>  arch/arm/boot/dts/zynq-zc702.dts      | 2 ++
>>  arch/arm/boot/dts/zynq-zc706.dts      | 2 ++
>>  arch/arm/boot/dts/zynq-zed.dts        | 2 ++
>>  arch/arm/boot/dts/zynq-zybo.dts       | 2 ++
>>  5 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
>> index 6a5f51daa708..45228a427006 100644
>> --- a/arch/arm/boot/dts/zynq-parallella.dts
>> +++ b/arch/arm/boot/dts/zynq-parallella.dts
>> @@ -35,7 +35,8 @@
>>  
>>  	chosen {
>>  		bootargs = "console=ttyPS0,115200 earlyprintk root=/dev/mmcblk0p2 rootfstype=ext4 rw rootwait";
>> -		linux,stdout-path = "/amba/serial at e0001000";
>> +		linux,stdout-path = &uart1;
>> +		stdout-path = &uart1;
> 
> Given that you added aliases in the last patch, you can use that to
> refer to the serial:
> 
> 	stdout-path - "serial0:115200n8";
> 
> With or without the alias you can encode the UART configuration here
> too:
> 
> 	stdout-path = "/amba/serial at e0001000:115200n8"

let me check this configuration if it is supported by u-boot.

> 
> Which makes the expected configuration explicit without relying on the
> Linux-specific bootargs.
> 
> Is there any reason to keep linux,stdout-path?

Agree when stdout-patch is defined there is no reason to use linux,stdout-patch.

Thanks,
Michal
