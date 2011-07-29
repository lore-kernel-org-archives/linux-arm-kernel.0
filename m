From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 29 Jul 2011 16:53:52 +0530
Subject: [PATCH 00/18] dmaengine/amba-pl08x updates
In-Reply-To: <20110729111920.GK25640@n2100.arm.linux.org.uk>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<20110729105759.GE25640@n2100.arm.linux.org.uk>
	<4E329616.2030505@st.com>
	<20110729111920.GK25640@n2100.arm.linux.org.uk>
Message-ID: <4E329848.7070606@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2011 04:49 PM, Russell King - ARM Linux wrote:
> Ok, so lets have the driver explicitly enforce one SG entry if peripheral
> flow is set.  It would also be a good idea to pass not zero length, but
> the real transfer size in the SG entry for the sake of having the API
> know the full information about the transfer.

In my case, JPEG driver doesn't know how much data to transfer. So i have to
send zero from there. Also, i am not sure why would peripheral needs to be
flow controller if the peripherals driver already know how much to transfer?

> 
> (Ok, it already only supports one SG entry, but that's something else
> which needs fixing - which may be possible now that you've cleaned up
> the LLI creation code.)
> .

Yes. I cleaned it up.

-- 
viresh
