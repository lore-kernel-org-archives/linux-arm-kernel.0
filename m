From: will.deacon@arm.com (Will Deacon)
Date: Thu, 27 Apr 2017 18:00:31 +0100
Subject: [PATCH 2/3] iommu/arm-smmu-v3: Add workaround for Cavium
 ThunderX2 erratum #74
In-Reply-To: <20170427164237.GA7114@leverpostej>
References: <1493293584-20287-1-git-send-email-gakula@caviumnetworks.com>
 <1493293584-20287-3-git-send-email-gakula@caviumnetworks.com>
 <20170427164237.GA7114@leverpostej>
Message-ID: <20170427170030.GF1890@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 05:42:37PM +0100, Mark Rutland wrote:
> On Thu, Apr 27, 2017 at 05:16:23PM +0530, Geetha sowjanya wrote:
> > +	/*
> > +	 * Override the size, for Cavium CN99xx implementations
> > +	 * which doesn't support the page 1 SMMU register space.
> > +	 */
> > +	cpu_model = read_cpuid_id() & MIDR_CPU_MODEL_MASK;
> > +	if (cpu_model == MIDR_THUNDERX_99XX ||
> > +	    cpu_model == MIDR_BRCM_VULCAN)
> > +		size = SZ_64K;
> 
> If you're trying to identify an SMMU erratum, identify the SMMU, not the
> CPU it happens to be paired with this time.
> 
> There are ID registers in the SMMU you can use to do so.
> 
> NAK to using the CPU ID here.

Agreed. I had some off-list discussion with Geetha where we agreed to use
the "silicon ID", which I assumed was the SMMU IIDR register.

Will
