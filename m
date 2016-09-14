From: yuanzhichang@hisilicon.com (zhichang.yuan)
Date: Wed, 14 Sep 2016 23:04:33 +0800
Subject: [PATCH V3 3/4] ARM64 LPC: support serial based on low-pin-count
In-Reply-To: <4340181.AghlmQIy28@wuerfel>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <1473855354-150093-4-git-send-email-yuanzhichang@hisilicon.com>
 <4340181.AghlmQIy28@wuerfel>
Message-ID: <57D96701.4050700@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/9/14 20:25, Arnd Bergmann wrote:
> On Wednesday, September 14, 2016 8:15:53 PM CEST Zhichang Yuan wrote:
>> From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
>>
>> On Hip06 platform, a 16550 compatible UART is connected to low-pin-count and
>> controlled through the LPC I/O cycles. After registering the LPC uart specific
>> serial_in/serial_out to 8250 core driver, serial data can be read/written
>> through the LPC.
>>
>> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
>>
> 
> I still think this should be handled by 8250_of.c after the addition of
> support for IORESOURCE_IO.

The 8250_hisi_lpc.c support both ACPI and dts similar to 8250_dw :

+static struct platform_driver hs_lpc8250_driver = {
+	.driver = {
+		.name		= "hisi-lpc-uart",
+		.of_match_table	= hs8250_of_match,
+		.acpi_match_table = ACPI_PTR(hs8250_acpi_match),

So, I am a little confused why we need to support dts in 8250_of.c and support ACPI in another
driver file.

best,
Zhichang


> 
> 	Arnd
> 
> 
> .
> 
