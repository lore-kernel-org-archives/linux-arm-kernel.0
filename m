From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Apr 2011 10:15:29 +0100
Subject: dmaengine: Can we schedule new transfer from dma callback
	routine??
In-Reply-To: <4DA7E997.3080402@st.com>
References: <4DA2B3D8.6060707@st.com>
	<20110411085603.GA13041@n2100.arm.linux.org.uk>
	<4DA7E997.3080402@st.com>
Message-ID: <20110415091529.GJ1611@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 12:15:43PM +0530, viresh kumar wrote:
> There is one more issue in the current DW_DMAC driver.
> As most of interrupt processing is done in tasklet, spin_lock_bh() is used
> in almost every routine.

As you can't use spin_lock_bh() from IRQ context (you'll get a lockdep
warning) these need to be converted to being the irqsave versions.
That's probably the easiest fix.
