From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 23 Apr 2013 15:56:35 -0400 (EDT)
Subject: [PATCH v4 15/15] ARM: vexpress: Select multi-cluster SMP operation
 if required
In-Reply-To: <20130423194237.GE5316@n2100.arm.linux.org.uk>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <1360041732-17936-16-git-send-email-nicolas.pitre@linaro.org>
 <20130423194237.GE5316@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.03.1304231554560.17375@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Apr 2013, Russell King - ARM Linux wrote:

> On Tue, Feb 05, 2013 at 12:22:12AM -0500, Nicolas Pitre wrote:
> > +void __init vexpress_smp_init_ops(void)
> > +{
> > +	struct smp_operations *ops = &vexpress_smp_ops;
> > +#ifdef CONFIG_CLUSTER_PM
> > +	extern struct smp_operations mcpm_smp_ops;
> > +	if(of_find_compatible_node(NULL, NULL, "arm,cci"))
> > +		ops = &mcpm_smp_ops;
> 
> Hmm, so these patches haven't been subjected to checkpatch treatment?
> As a seasoned kernel programmer, I'm surprised you haven't checked that
> already.

They have and fixes applied, although after this set was posted.  I 
didn't think it was worth a repost.


Nicolas
