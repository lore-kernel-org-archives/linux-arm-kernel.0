From: david@lechnology.com (David Lechner)
Date: Mon, 28 Mar 2016 10:02:10 -0500
Subject: [PATCH v3 02/16] mfd: da8xx-cfgchip: New header file for CFGCHIP
 registers.
In-Reply-To: <56F573F3.90500@cogentembedded.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
 <1458863503-31121-3-git-send-email-david@lechnology.com>
 <56F573F3.90500@cogentembedded.com>
Message-ID: <56F94772.7070009@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2016 12:22 PM, Sergei Shtylyov wrote:
> On 03/25/2016 02:51 AM, David Lechner wrote:
>> +/* register offsets */
>> +#define CFGCHIP_REG(n)                (n * 4)
>> +#define CFGCHIP0_REG                CFGCHIP_REG(0)
>> +#define CFGCHIP1_REG                CFGCHIP_REG(1)
>> +#define CFGCHIP2_REG                CFGCHIP_REG(2)
>> +#define CFGCHIP3_REG                CFGCHIP_REG(3)
>> +#define CFGCHIP4_REG                CFGCHIP_REG(4)
>
>     Why not just use CFGCHIP_REG(n) directly?

I considered that, but I went this way because A) the TRM uses, for 
example, "CFGCHIP2", so I wanted to keep "CFGCHIP" and "2" together and 
B) this tells you how many CFGCHIP registers there are, i.e. there is no 
CFGCHIP5_REG.

>> @@ -53,7 +31,6 @@ struct    da8xx_ohci_root_hub {
>>       /* Time from power on to power good (in 2 ms units) */
>>       u8    potpgt;
>>   };
>> -
>
>     Why?

Unintentional. Must have sneaked in through rebasing or something.
