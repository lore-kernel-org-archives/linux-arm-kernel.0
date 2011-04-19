From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 19 Apr 2011 11:37:33 +0530
Subject: [PATCH] tty/serial/pl011: don't print error msg if	dmaengine_pause
	is not supported
In-Reply-To: <20110418151340.GB25671@n2100.arm.linux.org.uk>
References: <98422bc7c3ebb4bf6a4ab26179b3f3b7d1a5b5ca.1303125086.git.viresh.kumar@st.com>
	<20110418151340.GB25671@n2100.arm.linux.org.uk>
Message-ID: <4DAD26A5.6080907@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2011 08:43 PM, Russell King - ARM Linux wrote:
> On Mon, Apr 18, 2011 at 04:52:00PM +0530, Viresh Kumar wrote:
>> Few dma controller doesn't support dmaengine_pause() and return -ENXIO if
>> dmaengine_pause() is called for them. Error messages such as "unable to pause
>> DMA transfer" shouldn't be printed for them.
> 
> It is _required_ to pause the DMA engine at this point, as we need to
> read characters via PIO.  Leaving the DMA engine active at this point
> invites it to transfer additional characters beneath us, before we've
> had time to properly update the DMA engine for the characters received.
> 
> So, dmaengine_pause() is a requirement for PL011.
> .
> 

Ok.
