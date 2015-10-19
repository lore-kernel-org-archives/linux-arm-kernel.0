From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 19 Oct 2015 18:32:36 +0100
Subject: [PATCH v3] arm-soc: Add support for Sigma Designs Tango4
In-Reply-To: <CAL_Jsq+jthx9ffnUm-G-TV9LdxBRp3SKyhyfcVu=7kN3CuumJw@mail.gmail.com>
References: <5124277.UR9sg1IOHT@wuerfel> <560EFDB3.9010305@free.fr>
 <11113740.WL812ZaRcZ@wuerfel> <5612A473.8030405@sigmadesigns.com>
 <5613EF4C.30603@sigmadesigns.com>
 <CAL_JsqJ+WTBYF=sJWbkgNzL48H5AiXL4aoVV3DNiL6T_UQKQfg@mail.gmail.com>
 <561D2952.4060908@sigmadesigns.com>
 <CAL_JsqKa4trfpLY_DPsjBrfH-7SSUQMACYVW7DNN1=Pv3B4FrA@mail.gmail.com>
 <5624CF62.6020001@sigmadesigns.com>
 <CAL_Jsq+jthx9ffnUm-G-TV9LdxBRp3SKyhyfcVu=7kN3CuumJw@mail.gmail.com>
Message-ID: <20151019173235.GF29001@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>>> No pl310? A9 performance mon?
> >
> > Found "arm,cortex-a9-pmu" in arch/arm/kernel/perf_event_v7.c
> > Are the PMU registers available from non-secure mode, or is TrustZone
> > going to get in the way?
> 
> I don't recall off-hand.

Judging by the access permissions tables in c12.9 of the ARM ARM (ARM DDI
0406C.c), they're always accessible from non-secure PL1 in the absence
of the virtualization extensions.

Thanks,
Mark.
