From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 11 Apr 2016 13:53:57 +0530
Subject: [PATCH v3 02/16] mfd: da8xx-cfgchip: New header file for CFGCHIP
 registers.
In-Reply-To: <56F95EE6.1010403@cogentembedded.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
 <1458863503-31121-3-git-send-email-david@lechnology.com>
 <56F573F3.90500@cogentembedded.com> <56F94772.7070009@lechnology.com>
 <56F95EE6.1010403@cogentembedded.com>
Message-ID: <570B5F1D.7030609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 March 2016 10:12 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 03/28/2016 06:02 PM, David Lechner wrote:
> 
>>>> +/* register offsets */
>>>> +#define CFGCHIP_REG(n)                (n * 4)
>>>> +#define CFGCHIP0_REG                CFGCHIP_REG(0)
>>>> +#define CFGCHIP1_REG                CFGCHIP_REG(1)
>>>> +#define CFGCHIP2_REG                CFGCHIP_REG(2)
>>>> +#define CFGCHIP3_REG                CFGCHIP_REG(3)
>>>> +#define CFGCHIP4_REG                CFGCHIP_REG(4)
>>>
>>>     Why not just use CFGCHIP_REG(n) directly?
>>
>> I considered that, but I went this way because A) the TRM uses, for
>> example,
>> "CFGCHIP2", so I wanted to keep "CFGCHIP" and "2" together

IMO, this is not that big of an issue. Anyone reading should be able to
make out that CFGCHIP_REG(0) is same as CFGCHIP0 referred to in the TRM.

> 
>    I'd just drop the _REG suffix.
> 
>> and B) this tells
>> you how many CFGCHIP registers there are, i.e. there is no CFGCHIP5_REG.
> 
>    You can tell that in a comment. Having a parametrized macro and using
> it to just #define more macros doesn't appeal to me at all...

Agree with Sergei, I don't prefer the additional #defines as well.

Regards,
Sekhar
