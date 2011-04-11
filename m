From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 11 Apr 2011 13:25:04 +0530
Subject: dmaengine: Can we schedule new transfer from dma callback routine??
Message-ID: <4DA2B3D8.6060707@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello,

In dw_dmac.c driver, dwc_descriptor_complete() routine, following is
mentioned before calling callback:

	/*
	 * The API requires that no submissions are done from a
	 * callback, so we don't need to drop the lock here
	 */
	if (callback)
		callback(param);

Does this hold true for dmaengine??

-- 
viresh
