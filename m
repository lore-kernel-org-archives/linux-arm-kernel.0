From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Wed, 19 Aug 2015 18:05:58 +0200
Subject: [PATCH v4 2/5] irqchip, gicv3: Workaround for Cavium ThunderX
 erratum 23154
In-Reply-To: <55D21345.3040903@caviumnetworks.com>
References: <1439576885-15621-1-git-send-email-rric@kernel.org>
 <1439576885-15621-3-git-send-email-rric@kernel.org>
 <55D21345.3040903@caviumnetworks.com>
Message-ID: <20150819160558.GY1820@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.08.15 10:00:53, David Daney wrote:
> On 08/14/2015 11:28 AM, Robert Richter wrote:
> >+config CAVIUM_ERRATUM_23154
> >+	bool "Cavium erratum 23154: Access to ICC_IAR1_EL1 is not sync'ed"
> >+	depends on ARCH_THUNDER
> 
> None of the other errata depend on a specific ARCH_*.  I think we should
> remove this 'depends on', so that a generic kernel can be configured to work
> on Thunder without having to first select ARCH_THUNDER.

Right, will remove the dependency. Same as for the other errata then.

Thanks,

-Robert

> >+	default y
> >+	help
> >+	  The gicv3 of ThunderX requires a modified version for
> >+	  reading the IAR status to ensure data synchronization
> >+	  (access to icc_iar1_el1 is not sync'ed before and after).
> >+
> >+	  If unsure, say Y.
