From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jan 2012 09:35:59 +0000
Subject: [PATCH 7/8] dmaengine/dw_dmac: Unmap all memory buffers after
 completion of slave transfers
In-Reply-To: <4F153A3E.8010409@st.com>
References: <cover.1326707233.git.viresh.kumar@st.com>
 <5e5d0fcff79b9b78e64c7424317d6b77736eca43.1326707233.git.viresh.kumar@st.com>
 <20120116105448.GT1068@n2100.arm.linux.org.uk> <4F140DB7.3060300@st.com>
 <CACRpkdY-4wWeD=3mJiChi6+4=iBMcd3kVh3h4JmDZ5ySXY3KCA@mail.gmail.com>
 <4F153A3E.8010409@st.com>
Message-ID: <20120118093559.GB1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2012 at 02:37:10PM +0530, Viresh Kumar wrote:
> On 1/17/2012 2:22 PM, Linus Walleij wrote:
> > Basically the driver using the dmaengine shall map/unmap buffers
> > used for slave transfers, not the driver.
> > 
> > I usually map them before setting up a transfer and unmaps them
> > when egtting the callback from the DMA engine that the transfer is
> > complete.
> > 
> 
> You implemented similar stuff in amba-pl08x :) .
> 
> if (!plchan->slave)
> 	pl08x_unmap_buffers(txd);

Take a look at that.  "If *NOT* slave, unmap the buffers".  That is in
keeping with what I've been saying.  Slave transfers *do* *not* get
automatic buffer unmapping.
