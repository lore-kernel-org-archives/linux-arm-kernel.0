From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 11 May 2011 09:37:19 +0530
Subject: [QUERY] Behavior of spi slave memories w.r.t chip select signal.
Message-ID: <4DCA0B77.8060700@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello,

Following is what i understood after reading m25p80 driver and spi master
drivers in drivers/spi folder.

"chip_select signal controls start and end of transfer. For ex: if we have to read
status reg of spi memory, then we use write_and_then_read() routine. which writes
0x9F in one spi transfer and writes dummy bytes and reads rx reg in other transfer.
And these two transfers are part of single spi_message.

Now, it is controllable to handle cs, and if we send cs_change == 0, then chip select
is activated at start of message and deactivated at end of message, instead at end
of every transfer.

Which means, even if there is a delay between command and dummy bytes received at
spi memory, current transfer will not be terminated by memory as cs is low."

Is this correct??

Actually i am seeing a different behavior by some of the spi memories, like m25p10.
If there is a delay between read_sts_reg command and dummy bytes, then 0xFFFFFF is
returned in response. If there is no delay then transfer always passes.

-- 
viresh
