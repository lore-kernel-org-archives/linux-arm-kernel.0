From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jan 2012 09:36:20 +0000
Subject: [PATCH V2 08/12] dmaengine/dw_dmac: Unmap all memory buffers
 after completion of slave transfers
In-Reply-To: <ba53f229f3f594bfe0459b01a9ebb4d9b2c15882.1326876464.git.viresh.kumar@st.com>
References: <cover.1326876464.git.viresh.kumar@st.com>
 <ba53f229f3f594bfe0459b01a9ebb4d9b2c15882.1326876464.git.viresh.kumar@st.com>
Message-ID: <20120118093620.GC1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 02:41:55PM +0530, Viresh Kumar wrote:
> Currently, after completion of transfer, source address or destination address
> of only the first LLI descriptor is unmapped. And length passed for unmap is
> total length of all descriptors in the list. Which means unmapping code assumed
> that the memory buffers pointed to by the descriptors will be physically
> contiguous, which might not be the case. It is possible for other drivers to
> pass sglist to slave_sg(), in which all buffers are scattered throughout the
> memory.
> 
> This patch intends to fix this wrong expectation of dw_dmac. Now, first desc
> will not contain total length of transfer. But individual descriptors will
> contain their individual lengths. Finally, we will call unmap for all
> descriptors.

NAK.  For reasons stated previously and subsequently ignored.
