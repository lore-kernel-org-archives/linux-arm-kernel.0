From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 10 Jun 2016 13:47:43 +0200
Subject: [RFC PATCH 05/15] tty: serial: samsung: fixup accessors for endian
In-Reply-To: <71328b3d-dc2f-3eb9-b664-4d621db23131@codethink.co.uk>
References: <20160608183110.13851-1-matthew@mattleach.net>
 <20160608183110.13851-6-matthew@mattleach.net>
 <71328b3d-dc2f-3eb9-b664-4d621db23131@codethink.co.uk>
Message-ID: <575AA8DF.9020701@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2016 12:13 PM, Ben Dooks wrote:
> On 08/06/16 19:31, Matthew Leach wrote:
>> Fix the serial access code to deal with kernels built for big endian
>> operation.
>>
>> Signed-off-by: Matthew Leach <matthew@mattleach.net>
>> ---
>> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> CC: Jiri Slaby <jslaby@suse.com>
>> CC: linux-serial at vger.kernel.org
>> CC: linux-kernel at vger.kernel.org
>> ---
>>  drivers/tty/serial/samsung.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
>> index fc5deaa..8818bdd 100644
>> --- a/drivers/tty/serial/samsung.h
>> +++ b/drivers/tty/serial/samsung.h
>> @@ -118,9 +118,9 @@ struct s3c24xx_uart_port {
>>  	((unsigned long *)(unsigned long)((port)->membase + (reg)))
>>  
>>  #define rd_regb(port, reg) (__raw_readb(portaddr(port, reg)))
>> -#define rd_regl(port, reg) (__raw_readl(portaddr(port, reg)))
>> +#define rd_regl(port, reg) (readl_relaxed(portaddr(port, reg)))
> 
> For completeness we should have changed __raw_readb to readb_relaxed
> 
>>  #define wr_regb(port, reg, val) __raw_writeb(val, portaddr(port, reg))
>> -#define wr_regl(port, reg, val) __raw_writel(val, portaddr(port, reg))
>> +#define wr_regl(port, reg, val) writel_relaxed(val, portaddr(port, reg))
> 
> Acked-by: Ben Dooks <ben.dooks@codethink.co.uk>


With the readb_relaced change:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
