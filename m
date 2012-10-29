From: x0148406@ti.com (Afzal Mohammed)
Date: Mon, 29 Oct 2012 16:58:48 +0530
Subject: [PATCH 4/4] OMAP: mtd: gpmc: add DT bindings for GPMC timings
 and NAND
In-Reply-To: <508E654B.5010404@gmail.com>
References: <1350935758-9215-1-git-send-email-zonque@gmail.com>
 <1350935758-9215-5-git-send-email-zonque@gmail.com>
 <20121024232717.GD11928@atomide.com> <50887A6B.3050108@gmail.com>
 <508E3A0F.3040309@ti.com> <508E654B.5010404@gmail.com>
Message-ID: <508E6870.7000807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Monday 29 October 2012 04:45 PM, Daniel Mack wrote:
> On 29.10.2012 09:10, Afzal Mohammed wrote:

>> Also perhaps memory size (and offset if
>> needed) to be mapped for peripherals can go with reg
>> property of child.

> Which detail are you referring to here? The only "size" property that is
> effective is the one of the generic GPMC block, and there it's in the
> "reg"-property.

I was referring to that of child, now in gpmc_nand_init(),
gpmc_cs_request() is being done, later on if we want to
make it generic and remove gpmc_nand_init(), additional
information that would be required from DT at least is the
memory size to be reserved in gpmc address space for
the connected peripheral (assuming gpmc_cs_request()
would be done by gpmc driver generically later)

What I had in mind was example for external bus in [1],
but I had not looked deep into this aspect yet.

Regards
Afzal

[1] http://devicetree.org/Device_Tree_Usage#Memory_Mapped_Devices
