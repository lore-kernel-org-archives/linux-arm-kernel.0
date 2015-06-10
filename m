From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 10 Jun 2015 11:11:04 +0100
Subject: [PATCH] arm64: dts: add device tree for ARM SMM-A53x2 on
 LogicTile Express 20MG
In-Reply-To: <1433930360.3418.0.camel@arm.com>
References: <1433864311-2326-1-git-send-email-kristina.martsenko@arm.com>
 <20150610085825.GS12807@e106497-lin.cambridge.arm.com>
 <20150610091234.GA1517@leverpostej>
 <20150610092726.GV12807@e106497-lin.cambridge.arm.com>
 <20150610093930.GC1517@leverpostej>
 <1433930360.3418.0.camel@arm.com>
Message-ID: <20150610101104.GF1517@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 10, 2015 at 10:59:20AM +0100, Pawel Moll wrote:
> On Wed, 2015-06-10 at 10:39 +0100, Mark Rutland wrote:
> > Ideally we'd avoid placing the enable-method in the DTS at all, but I
> > believe the boot monitor isn't smart enough to fix that up.
> 
> You would be surprised how intelligent these animals can be :-P
> 
> 8<--------------
>     case CPU:
>         err = safdt_insert_prop(safdt, "enable-method",
>                                 "spin-table", 11);
>         if (err)
>             break;
>         addr = fdt_uint64(parser->cpu_release_addr);
>         err = safdt_insert_prop(safdt, "cpu-release-addr", &addr, 8);
> 8<---------------

Sounds like we can get rid of the enable-method and cpu-release-addr
then.

Mark.
