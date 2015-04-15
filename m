From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 15 Apr 2015 15:17:11 +0100
Subject: [PATCH] irqchip/gicv3-its: Decrease page size when needed
In-Reply-To: <20150415115118.GN18660@io.lakedaemon.net>
References: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
 <20150415115118.GN18660@io.lakedaemon.net>
Message-ID: <8ba82758f57122dd360b2e6fac8040fc@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-04-15 12:51, Jason Cooper wrote:
> Minghuan Lian,
>
> On Wed, Apr 15, 2015 at 05:49:22PM +0800, Minghuan Lian wrote:
>> The default page size of ITS table has been changed to 64KB,
>> but for some platforms the real size of allocate memory which
>> calculated by DEVBITS of register GITS_TYPER may smaller than
>> default size. In this case, psz must be decreased, otherwise,
>> the wrong page number will cause kernel hang.
>>
>> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c | 3 +++
>>  1 file changed, 3 insertions(+)
>
> Please run scripts/get_maintainer.pl on your patches before sending.  
> This
> needs to be sent to myself and Thomas Gleixner for review.

Please also CC me on anything that touches GICv3 or the ITS code.

Thanks,

         M.
-- 
Fast, cheap, reliable. Pick two.
