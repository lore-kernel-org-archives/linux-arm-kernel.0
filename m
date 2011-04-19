From: vinod.koul@intel.com (Koul, Vinod)
Date: Tue, 19 Apr 2011 11:42:24 +0530
Subject: [PATCH 2/6] dmaengine/dw_dmac: Enable resubmission from
	callback routine.
In-Reply-To: <cf350c267897bd4eaf5a027c659771eee117ac74.1303123511.git.viresh.kumar@st.com>
References: <e52c8e679fbf3007cf7e5e4bcfc86ea208a09d7c.1303123511.git.viresh.kumar@st.com>
	<cf350c267897bd4eaf5a027c659771eee117ac74.1303123511.git.viresh.kumar@st.com>
Message-ID: <438BB0150E931F4B9CE701519A44630108519E1BE6@bgsmsx502.gar.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2011 04:20 PM, viresh kumar wrote:
> 
> Resubmission of new transfer must be allowed from callbacks. For this release
> lock before calling callback routine and enable them again.
Why would you like to do that?

IMO it's not a good thing as you are essentially doing it in your tasklet...
Make sure the submit() is done by client before this and you use it to start
next transaction in you tasklet and let client know in callback txn is
finished.

~Vinod
