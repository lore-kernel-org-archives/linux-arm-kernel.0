From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Nov 2014 14:10:35 +0100
Subject: [PATCH v5 5/6] Documentation: dt-bindings: Add binding info for
 X-Gene QMTM UIO driver
In-Reply-To: <CAPTm99WYNyxtY-NCVN8pB0HwNPn+EFx-7w7yEevaEK1z7-Zqxg@mail.gmail.com>
References: <1416220572-13381-1-git-send-email-ankit.jindal@linaro.org>
 <2279061.naADrHDgyn@wuerfel>
 <CAPTm99WYNyxtY-NCVN8pB0HwNPn+EFx-7w7yEevaEK1z7-Zqxg@mail.gmail.com>
Message-ID: <1503477.DVdkExccIe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 November 2014 14:59:54 Ankit Jindal wrote:
> On 17 November 2014 16:47, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 17 November 2014 16:06:11 Ankit Jindal wrote:
> >> +
> >> +       qmtm1_uio: qmtm_uio at 1f200000 {
> >> +               compatible = "apm,xgene-qmtm";
> >> +               status = "disabled";
> >> +               reg = <0x0 0x1f200000 0x0 0x10000>,
> >> +                     <0x0 0x1b000000 0x0 0x400000>;
> >> +               reg-names = "csr", "fabric";
> >> +               qpool-memory = <&qmtm1_uio_qpool>;
> >> +               clocks = <&qmtm1clk 0>;
> >> +               num-queues = <0x400>;
> >> +               devid = <1>;
> >> +       };
> >> +
> >
> > To make my previous review comments clearer:
> >
> > NAK
> >
> > Do not create device nodes that are meant for a specific use case in
> > software and that are not usable for the common case. I don't think
> > it makes any sense to keep on submitting a UIO driver for this until
> > we have a proper network driver that uses this so we can make sure we
> > have a working binding.
> 
> The dataplane frameworks like OpenDataPlane etc, need to have access
> to complete subsystem from the user space. Hence, we would like to
> have this driver and some other UIO drivers to be the part of kernel
> to have data plane frameworks working on our platform.

Please work with the people that do the in-kernel QMTM driver to come
up with a common binding then.

	Arnd
