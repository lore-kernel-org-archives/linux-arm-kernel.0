From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 28 Mar 2016 19:42:14 +0300
Subject: [PATCH v3 02/16] mfd: da8xx-cfgchip: New header file for CFGCHIP
 registers.
In-Reply-To: <56F94772.7070009@lechnology.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
 <1458863503-31121-3-git-send-email-david@lechnology.com>
 <56F573F3.90500@cogentembedded.com> <56F94772.7070009@lechnology.com>
Message-ID: <56F95EE6.1010403@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/28/2016 06:02 PM, David Lechner wrote:

>>> +/* register offsets */
>>> +#define CFGCHIP_REG(n)                (n * 4)
>>> +#define CFGCHIP0_REG                CFGCHIP_REG(0)
>>> +#define CFGCHIP1_REG                CFGCHIP_REG(1)
>>> +#define CFGCHIP2_REG                CFGCHIP_REG(2)
>>> +#define CFGCHIP3_REG                CFGCHIP_REG(3)
>>> +#define CFGCHIP4_REG                CFGCHIP_REG(4)
>>
>>     Why not just use CFGCHIP_REG(n) directly?
>
> I considered that, but I went this way because A) the TRM uses, for example,
> "CFGCHIP2", so I wanted to keep "CFGCHIP" and "2" together

    I'd just drop the _REG suffix.

> and B) this tells
> you how many CFGCHIP registers there are, i.e. there is no CFGCHIP5_REG.

    You can tell that in a comment. Having a parametrized macro and using it 
to just #define more macros doesn't appeal to me at all...

MBR, Sergei
