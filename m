From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Wed, 6 Feb 2013 23:27:10 -0500
Subject: DMAEngine and channel pairs
Message-ID: <CAKON4Oxmvc3ShbFVoeGH5ftcDNPSi9TN0bLp0bL9GF6yyTwF1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPU I'm working on uses two sequential DMA channels to implement
scatter-gather.  How do you handle this in the channel allocator? If
scatter-gather is not requested the two channels work fine as normal
DMA channels.

So when a scatter-gather channel is requested my driver needs to fail
the dma_alloc_chan_resources() requests until a sequential pair is
located? Plus I need to track what channels are used in my driver so
that I know where sequential pairs are. Is there a better way to do
this?

Another solution might be to statically allocate some channels as
being scatter/gather capable and others as not being able to do it. I
would just report fewer available channels to dmaengine and hide those
secondary channels from it. I have 12 channels to work with.

--
Jon Smirl
jonsmirl at gmail.com
