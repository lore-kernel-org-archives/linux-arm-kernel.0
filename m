From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 26 Jul 2013 16:56:45 +0100
Subject: [RFC PATCH 3/3] cpuidle: big.LITTLE: vexpress-TC2 CPU idle driver
In-Reply-To: <alpine.LFD.2.03.1307261058510.15022@syhkavp.arg>
References: <1374750866-750-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1374750866-750-4-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.03.1307261058510.15022@syhkavp.arg>
Message-ID: <20130726155645.GD28084@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 04:00:48PM +0100, Nicolas Pitre wrote:
> On Thu, 25 Jul 2013, Lorenzo Pieralisi wrote:
> 
> > +static int notrace bl_powerdown_finisher(unsigned long arg)
> > +{
> > +	/* MCPM works with HW CPU identifiers */
> > +	unsigned int mpidr = read_cpuid_mpidr();
> > +	unsigned int cluster = (mpidr >> 8) & 0xf;
> > +	unsigned int cpu = mpidr & 0xf;
> 
> You probably want to use the MPIDR_AFFINITY_LEVEL() macro here.

Bah, I am so used to this pattern I don't notice anymore. Changed.

Thanks !
Lorenzo
