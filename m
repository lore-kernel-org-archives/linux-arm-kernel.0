From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 24 Feb 2011 17:39:44 +0100
Subject: [PATCH V11 2/4] ptp: Added a clock that uses the eTSEC found
	on the MPC85xx.
In-Reply-To: <20110223175459.GH14597@angua.secretlab.ca>
References: <cover.1298447722.git.richard.cochran@omicron.at>
	<be1f5e801e8cd0145dd23aadae7c2055bb3c1d47.1298447722.git.richard.cochran@omicron.at>
	<20110223165058.GE14597@angua.secretlab.ca>
	<20110223112612.30071995@schlenkerla>
	<20110223175459.GH14597@angua.secretlab.ca>
Message-ID: <20110224163944.GA15234@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 23, 2011 at 10:54:59AM -0700, Grant Likely wrote:
> On Wed, Feb 23, 2011 at 11:26:12AM -0600, Scott Wood wrote:

> > The eTSEC revision is probeable as well, but due the way PTP is described as
> > a separate node, the driver doesn't have straightforward access to those
> > registers.
> 
> Ignorant question: Should the ptp be described as a separate node?

Well, the PTP Hardware Clock function is logically separate from the
MAC function. PHCs can be implemented in the MAC, in the PHY, or in
between in an FPGA on MII bus.

If the PHC is in the MAC, then it might be wise to implement one
driver that offers both the MAC and the PHC.

In the case of gianfar, it is not really necessary to combine the PHC
into the gianfar driver, since the registers are pretty well
separated. Also, given the size and complexity (and churn over time)
of the gianfar driver, I decided to keep the PHC separate.

Right now, the driver correctly handles all the clock revisions in the
boards that I have (mpc8313, mpc8572, p2020ds, p2020rdb).

If checking the revision becomes important, then we can always export
a function from gianfar to provide this.

Thanks,

Richard
