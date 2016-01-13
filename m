From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 13 Jan 2016 09:52:37 +0800
Subject: [PATCH V2 03/10] irqchip,GICv3,ACPI: Add redistributor support
 via GICC structures.
In-Reply-To: <56952DA1.4030401@semihalf.com>
References: <1450353133-15992-1-git-send-email-tn@semihalf.com>
 <1450353133-15992-4-git-send-email-tn@semihalf.com>
 <5694EB92.9030109@arm.com> <56952DA1.4030401@semihalf.com>
Message-ID: <5695ADE5.7010501@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/1/13 0:45, Tomasz Nowicki wrote:
> On 12.01.2016 13:03, Marc Zyngier wrote:
>
>  > +    typer = readq_relaxed(redist_base + GICR_TYPER);
>  > +    /* don't map reserved page as it's buggy to access it */
>  > +    size = (typer & GICR_TYPER_VLPIS) ? SZ_64K * 3 : SZ_64K * 2;
>
> [...]
>
>> Also, please map the whole region for the
>> redistributor as we have on the DT side (4 64kB pages for VLPIS capable
>> redistributors).
>
> Hanjun, is it something you had problem with?

Yes, for D02, it use 3 64kB pages for GICv4, it removed the reserved
page. In DT case, it has "stride" binding so it can support no standard
cases, seems that we can introduce "stride" for ACPI too.

Thanks
Hanjun
