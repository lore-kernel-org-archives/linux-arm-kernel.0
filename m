From: x0148406@ti.com (Afzal Mohammed)
Date: Mon, 29 Oct 2012 18:26:04 +0530
Subject: [PATCH 4/4] OMAP: mtd: gpmc: add DT bindings for GPMC timings
 and NAND
In-Reply-To: <508E7767.40804@gmail.com>
References: <1350935758-9215-1-git-send-email-zonque@gmail.com>
 <1350935758-9215-5-git-send-email-zonque@gmail.com>
 <20121024232717.GD11928@atomide.com> <50887A6B.3050108@gmail.com>
 <508E3A0F.3040309@ti.com> <508E654B.5010404@gmail.com>
 <508E6870.7000807@ti.com> <508E7767.40804@gmail.com>
Message-ID: <508E7CE4.9070802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Monday 29 October 2012 06:02 PM, Daniel Mack wrote:
> On 29.10.2012 12:28, Afzal Mohammed wrote:

>> I was referring to that of child, now in gpmc_nand_init(),
>> gpmc_cs_request() is being done, later on if we want to
>> make it generic and remove gpmc_nand_init(), additional
>> information that would be required from DT at least is the
>> memory size to be reserved in gpmc address space for
>> the connected peripheral (assuming gpmc_cs_request()
>> would be done by gpmc driver generically later)
>>
>> What I had in mind was example for external bus in [1],
>> but I had not looked deep into this aspect yet.

> Ok, now I see what you mean.
>
> I would say we can use the "reg" property in child node for CS numbers
> purely and if we want to get rid of the memory node allocation, we
> should use a property in the gpmc top-node for this, something like:
>
> 	gpmc: gpmc at 50000000 {
> 		compatible = "ti,gpmc";
> 		cs-regs =<0x51000000 0x10000000 ...>;

I think you meant cs-regs = <0x00000000 ..>

0x0 - 0x1fffffff is gpmc external memory address space, while
0x50000000 to plus 16MB is gpmc configuration address space.

You may refer other gpmc peripheral init's that are NOR type.

> Changing the meaning of the reg property of children from "cs number" to
> "memory sub-region" later is something I would like to avoid.

Changing any of the properties later is something we have
to avoid. Let us get feedback from DT maintainers.

Regards
Afzal
