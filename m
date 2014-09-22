From: monstr@monstr.eu (Michal Simek)
Date: Mon, 22 Sep 2014 11:36:53 +0200
Subject: [PATCH 1/2] i2c: cadence: Remove .owner field for driver
In-Reply-To: <20140920091106.GB1612@katana>
References: <c076984af7e65c433fdfd3a3b0f8d20da2c18013.1407931005.git.michal.simek@xilinx.com>
 <20140920091106.GB1612@katana>
Message-ID: <541FEDB5.7050305@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20/2014 11:11 AM, Wolfram Sang wrote:
> On Wed, Aug 13, 2014 at 01:56:51PM +0200, Michal Simek wrote:
>> There is no need to init .owner field.
>>
>> Based on the patch from Peter Griffin <peter.griffin@linaro.org>
>> "mmc: remove .owner field for drivers using module_platform_driver"
								     ^
this shouldn't be there.

>>
>> This patch removes the superflous .owner field for drivers which
> 
> It says drivers, but does only one...

I have c&p this from Peter's description that's why there are just drivers.

> 
>> use the module_platform_driver API, as this is overriden in
>> platform_driver_register anyway."
> 
> ... so: any interest in doing this for the whole subsystem? Basically
> good catch, though.

Mark was also interested about doing this for spi. Doing this for the whole
kernel will be the best. coccinelle script
is good option I have never played with it.

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
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140922/9088a705/attachment.sig>
