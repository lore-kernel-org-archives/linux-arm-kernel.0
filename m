From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 13 May 2011 09:22:57 +0530
Subject: [QUERY] Behavior of spi slave memories w.r.t chip select signal.
In-Reply-To: <4DCA0B77.8060700@st.com>
References: <4DCA0B77.8060700@st.com>
Message-ID: <4DCCAB19.2020302@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2011 09:37 AM, viresh kumar wrote:
> 
> Hello,
> 
> Following is what i understood after reading m25p80 driver and spi master
> drivers in drivers/spi folder.
> 
> "chip_select signal controls start and end of transfer. For ex: if we have to read
> status reg of spi memory, then we use write_and_then_read() routine. which writes
> 0x9F in one spi transfer and writes dummy bytes and reads rx reg in other transfer.
> And these two transfers are part of single spi_message.
> 
> Now, it is controllable to handle cs, and if we send cs_change == 0, then chip select
> is activated at start of message and deactivated at end of message, instead at end
> of every transfer.
> 
> Which means, even if there is a delay between command and dummy bytes received at
> spi memory, current transfer will not be terminated by memory as cs is low."
> 
> Is this correct??
> 
> Actually i am seeing a different behavior by some of the spi memories, like m25p10.
> If there is a delay between read_sts_reg command and dummy bytes, then 0xFFFFFF is
> returned in response. If there is no delay then transfer always passes.
> 

Linus, Jamie,

Have you ever seen this kind of issue? Which spi slave memories did you used for testing?
I am using standard pl0022 and m25p80 driver. Tried in all modes: polling, interrupt, dma.

-- 
viresh
