From: monstr@monstr.eu (Michal Simek)
Date: Wed, 21 Sep 2016 09:22:09 +0200
Subject: [PATCH] gpio: Added zynq specific check for special pins on bank
 zero
In-Reply-To: <20160920140633.GD16583@xsjsorenbubuntu>
References: <1474360324-8168-1-git-send-email-navam@xilinx.com>
 <20160920140633.GD16583@xsjsorenbubuntu>
Message-ID: <d4d36022-aa3a-d49c-e008-626e20e35b9e@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.9.2016 16:06, S?ren Brinkmann wrote:
> On Tue, 2016-09-20 at 14:02:04 +0530, Nava kishore Manne wrote:
>> From: Nava kishore Manne <nava.manne@xilinx.com>
>>
>> This patch adds zynq specific check for bank 0 pins 7 and 8
>> are special and cannot be used as inputs
>>
>> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
>> ---
>>  drivers/gpio/gpio-zynq.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
>> index e72794e..eae9d24 100644
>> --- a/drivers/gpio/gpio-zynq.c
>> +++ b/drivers/gpio/gpio-zynq.c
>> @@ -96,6 +96,10 @@
>>  /* GPIO upper 16 bit mask */
>>  #define ZYNQ_GPIO_UPPER_MASK 0xFFFF0000
>>  
>> +/* For GPIO quirks */
>> +#define ZYNQ_GPIO	BIT(0)
>> +#define ZYNQMP_GPIO	BIT(1)
> 
> I'd make sure all quirks are easily identifiable and call them something
> like 'ZYNQ_GPIO_QUIRK_FOO'
> 
> Apart from that:
> Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
> 

This issue was:
Reported-by: Jonas Karlsson <Jonas.d.karlsson@gmail.com>

And here is also my:
Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160921/7059a368/attachment.sig>
