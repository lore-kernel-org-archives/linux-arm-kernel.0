From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 28 Mar 2013 10:51:11 -0400 (EDT)
Subject: [PATCH v3] [RFC] arm: use PSCI if available
In-Reply-To: <alpine.DEB.2.02.1303281225050.4430@kaball.uk.xensource.com>
References: <1364388639-11210-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130327133811.GE18429@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1303271610430.4430@kaball.uk.xensource.com>
 <20130327172306.GB20990@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1303281225050.4430@kaball.uk.xensource.com>
Message-ID: <alpine.LFD.2.03.1303281048060.1372@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Mar 2013, Stefano Stabellini wrote:

> - the interface to bring up secondary cpus is different and based on
> PSCI, in fact Xen is going to add a PSCI node to the device tree so that
> Dom0 can use it.
> 
> Oh wait, Dom0 is not going to use the PSCI interface even if the node is
> present on device tree because it's going to prefer the platform smp_ops
> instead.

Waitaminute...  I must have missed this part.

Who said platform specific methods must be used in preference to PSCI?

If DT does provide PSCI description, then PSCI should be used.  Doing 
otherwise is senseless.  If PSCI is not to be used, then it should not 
be present in DT.


Nicolas
