From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 16 Jan 2015 15:25:41 +0000
Subject: [PATCH v7 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <2198633.UpIyI82Yon@wuerfel>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <54B9240A.7060003@amd.com> <20150116145545.GR7091@arm.com>
 <2198633.UpIyI82Yon@wuerfel>
Message-ID: <20150116152541.GG13634@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 03:14:13PM +0000, Arnd Bergmann wrote:
> On Friday 16 January 2015 14:55:45 Will Deacon wrote:
> > On Fri, Jan 16, 2015 at 02:45:30PM +0000, Tom Lendacky wrote:
> > > I have tested ACPI-enablement patches for the amd-xgbe/amd-xgbe-phy
> > > drivers that I'm about to submit upstream with the V7 patch series
> > > on the AMD Seattle server platform. There does not appear to be support
> > > for the _CCA attribute in this patch series. The amd-xgbe driver will
> > > setup the device domain and cache attributes based on the presence of
> > > this attribute, but it requires the arch support to assign the proper
> > > DMA operations in order for it to all work correctly.
> > > 
> > > Overriding the _CCA attribute in the driver, I was able to successfully
> > > test the driver and this patch series.
> > 
> > Hopefully this will all be addressed when the IORT parts of ACPI have
> > settled down (the current proposal allows for these attributes to be
> > described as well as their interaction with things like IOMMUs).
> > 
> > In the meantime, are you falling back to non-coherent DMA? If so, what
> > attributes have you settled on? We need to be really careful not to
> > corrupt data during cache invalidatation when mapping a non-coherent
> > buffer for the CPU.
> 
> I think in case of ACPI we should use cache-coherent as the default,
> as this is what all servers will use for DMA masters.

Last time I heard in some call, it was agreed that _CCA properties
should always be present and Linux should not make any assumption (there
is no safe assumption here). While better options may appear in ACPI,
_CCA is what we currently have.

-- 
Catalin
