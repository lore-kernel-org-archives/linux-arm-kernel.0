From: robherring2@gmail.com (Rob Herring)
Date: Fri, 1 Nov 2013 17:43:22 -0500
Subject: [PATCH 1/2] arm: correct GIC cpu interface range for Cortex
 A15/GIC 400
In-Reply-To: <1383300809-7527-1-git-send-email-ian.campbell@citrix.com>
References: <1383300776.4332.3.camel@hastur.hellion.org.uk>
 <1383300809-7527-1-git-send-email-ian.campbell@citrix.com>
Message-ID: <CAL_JsqL4TA48ZhrMuxd+DNUF_O28wRLiX=o08To4WHRSTkwNVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 1, 2013 at 5:13 AM, Ian Campbell <ian.campbell@citrix.com> wrote:
> GICv2 (Cortex A15/GIC 400) have CPU interface registers up to offset 0x1004
> (the 32-bit GICC_DIR register a 0x1000). The GIC 400 documentation specifies
> the CPU interface region as being 0x2000 in size.
>
> Update all DTS entries claiming "arm,cortex-a15-gic" compatibility. Of these I
> only have personal experience with the vexpress a Calxeda (ecx) platforms and
> annecdotal evidence for omap and exynos. For the others I'm just assuming.
>
> Also update the example a15 binding in the documentation.
>
> The "Texas Instruments Keystone 2 SoC" platform which claim to have an a15
> compatible GIC but does not include the GICH/GICV registers. I've not touched
> that here.
>
> Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org

Acked-by: Rob Herring <rob.herring@calxeda.com>
