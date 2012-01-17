From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Jan 2012 14:37:10 +0530
Subject: [PATCH 7/8] dmaengine/dw_dmac: Unmap all memory buffers after
 completion of slave transfers
In-Reply-To: <CACRpkdY-4wWeD=3mJiChi6+4=iBMcd3kVh3h4JmDZ5ySXY3KCA@mail.gmail.com>
References: <cover.1326707233.git.viresh.kumar@st.com>
 <5e5d0fcff79b9b78e64c7424317d6b77736eca43.1326707233.git.viresh.kumar@st.com>
 <20120116105448.GT1068@n2100.arm.linux.org.uk>	<4F140DB7.3060300@st.com>
 <CACRpkdY-4wWeD=3mJiChi6+4=iBMcd3kVh3h4JmDZ5ySXY3KCA@mail.gmail.com>
Message-ID: <4F153A3E.8010409@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/17/2012 2:22 PM, Linus Walleij wrote:
> Basically the driver using the dmaengine shall map/unmap buffers
> used for slave transfers, not the driver.
> 
> I usually map them before setting up a transfer and unmaps them
> when egtting the callback from the DMA engine that the transfer is
> complete.
> 

You implemented similar stuff in amba-pl08x :) .

if (!plchan->slave)
	pl08x_unmap_buffers(txd);

> Why do you want to do this?

This is because people can pass in flags which are
DMA_COMPL_SKIP_SRC_UNMAP, etc.

If they are not passed, then DMA driver must do it for them.

Sorry if i am understanding the DMA logic incorrectly.

-- 
viresh
