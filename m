From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Dec 2011 11:29:12 +0000
Subject: [PATCH] ARM: make head.S register assignments more convenient
In-Reply-To: <20111206111105.GA2270@linaro.org>
References: <alpine.LFD.2.02.1112051528200.2357@xanadu.home>
 <20111206111105.GA2270@linaro.org>
Message-ID: <20111206112912.GR14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 11:11:05AM +0000, Dave Martin wrote:
> Is it also worth changing the other proc-*.S setup rountines to be PCS
> compliant too?  This would clean up the calling convention further, and
> help avoid future sutprises.

They _aren't_ PCS functions in any case.  They don't have a stack
available to them.  So, having them as non-PCS functions reinforces
the fact that they _are_ special.
