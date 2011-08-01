From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 1 Aug 2011 17:25:42 +0530
Subject: [PATCH V2 08/20] dmaengine/amba-pl08x: support runtime PM
In-Reply-To: <20110801102627.GF15578@n2100.arm.linux.org.uk>
References: <cover.1312190881.git.viresh.kumar@st.com>
	<bc59bbd3709a7af1723d37ab846bf44c6867c00e.1312190881.git.viresh.kumar@st.com>
	<20110801102627.GF15578@n2100.arm.linux.org.uk>
Message-ID: <4E36943E.5020105@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2011 03:56 PM, Russell King - ARM Linux wrote:
> I think a primecell's probe function should look like this:
> 
> primecell_probe()
> {
> 	ret = amba_request_regions(adev, NULL);
> 	if (ret)
> 		return ret;
> 
> 	... allocate stuff, don't access primecell though ...
> 
> 	pm_runtime_set_active(&adev->dev);
> 	pm_runtime_enable(&adev->dev);
> 
> 	... get clocks and enable them, do rest of init ...
> 
> 	pm_runtime_put_sync(&adev->dev);
> 	return 0;
> }

Ok. I didn't had much knowhow of pm_runtime* framework. I will
send V3 for this patch alone, please see if that one is fine or still
needs some updation.

Thanks for your help.

-- 
viresh
