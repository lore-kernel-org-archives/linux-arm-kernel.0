From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 13 May 2011 10:04:03 +0100
Subject: [QUERY] Behavior of spi slave memories w.r.t chip select signal.
In-Reply-To: <4DCCAB19.2020302@st.com>
References: <4DCA0B77.8060700@st.com>
 <4DCCAB19.2020302@st.com>
Message-ID: <20110513090403.GK8718@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2011 at 09:22:57AM +0530, viresh kumar wrote:
> On 05/11/2011 09:37 AM, viresh kumar wrote:
> > Actually i am seeing a different behavior by some of the spi 
> > memories, like m25p10.
> > If there is a delay between read_sts_reg command and dummy bytes, then 0xFFFFFF is
> > returned in response. If there is no delay then transfer always passes.
> > 
> 
> Linus, Jamie,
> 
> Have you ever seen this kind of issue? Which spi slave memories did you used for testing?
> I am using standard pl0022 and m25p80 driver. Tried in all modes: polling, interrupt, dma.

No, not that exact issue.  I've seen with the Synopsys DesignWare 
controller that the fifo emptying causing cs to drop can result in all 
0's being read back from a m25p80, but not all 1's.

Jamie
