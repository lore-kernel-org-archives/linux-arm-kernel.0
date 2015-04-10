From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 10 Apr 2015 11:08:33 +0100
Subject: [RFC PATCH 5/5] arm64: qcom: add cpu operations
In-Reply-To: <2294107.GTDFpLFyzQ@wuerfel>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <1428601031-5366-6-git-send-email-galak@codeaurora.org>
 <2294107.GTDFpLFyzQ@wuerfel>
Message-ID: <20150410100832.GB6854@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 11:19:02PM +0200, Arnd Bergmann wrote:
> On Thursday 09 April 2015 12:37:11 Kumar Gala wrote:
> > From: Abhimanyu Kapur <abhimany@codeaurora.org>
> > 
> > Add qcom cpu operations for arm-v8 cpus. Implement secondary cpu boot ops
> > As a part of this change update device tree documentation for:
> > 
> > 1. Arm cortex-a ACC device which provides percpu reg
> > 2. Armv8 cortex-a compatible string in arm/cpus.txt
> > 
> > Signed-off-by: Abhimanyu Kapur <abhimany@codeaurora.org>
> > Signed-off-by: Kumar Gala <galak@codeaurora.org>
> > ---
> >  Documentation/devicetree/bindings/arm/cpus.txt    |   2 +
> >  Documentation/devicetree/bindings/arm/msm/acc.txt |  19 ++
> >  drivers/soc/qcom/Makefile                         |   1 +
> >  drivers/soc/qcom/cpu_ops.c                        | 343 ++++++++++++++++++++++
> >  4 files changed, 365 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/msm/acc.txt
> 
> I don't want this in drivers/soc. Please find a way to integrate it into the
> arch/arm64 code.

And rename it to something like qc-special-cpu-ops-dont-copy-this.c

-- 
Catalin
