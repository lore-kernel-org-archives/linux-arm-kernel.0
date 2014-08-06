From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 6 Aug 2014 10:02:20 +0100
Subject: [PATCH v6 6/7] drivers: cpuidle: initialize big.LITTLE driver
 through DT
In-Reply-To: <20140723162626.GE20966@arm.com>
References: <1405958786-17243-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1405958786-17243-7-git-send-email-lorenzo.pieralisi@arm.com>
 <20140723162626.GE20966@arm.com>
Message-ID: <20140806090220.GA24431@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 05:26:26PM +0100, Catalin Marinas wrote:
> On Mon, Jul 21, 2014 at 05:06:25PM +0100, Lorenzo Pieralisi wrote:
> > With the introduction of DT based idle states, CPUidle drivers for ARM
> > can now initialize idle states data through properties in the device tree.
> > 
> > This patch adds code to the big.LITTLE CPUidle driver to dynamically
> > initialize idle states data through the updated device tree source file.
> > 
> > Cc: Chander Kashyap <chander.kashyap@linaro.org>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> I think for this patch (and the exynos one) we should still allow the
> driver to work fine with old DT. Basically if the information is not in
> DT, fall back to the original static definitions.

Yes, this makes sense, I will implement the fall-back mechanism on v7,
that should be final. If in the meanwhile Samsung guys have time to
test the Exynos patch that would be very appreciated.

Thanks,
Lorenzo
