From: joerg.krause@embedded.rocks (=?ISO-8859-1?Q?J=F6rg?= Krause)
Date: Thu, 15 Dec 2016 14:50:14 +0100
Subject: mmc: core: complete/wait_for_completion performance
In-Reply-To: <962480933.163666.1481741832090@email.1und1.de>
References: <1479644869.2653.3.camel@embedded.rocks>
 <585759233.283839.1cb53b4d-2805-48ea-aef1-dd282306d108.open-xchange@email.1und1.de>
 <1479652929.2841.1.camel@embedded.rocks>
 <187975187.249177.bccdc17e-e9c6-48c2-aeaf-3b81f1b61ec7.open-xchange@email.1und1.de>
 <1479669034.1975.1.camel@embedded.rocks>
 <1198138554.59982.63209ba1-8fb4-4a13-9ee0-f746a192f4c7.open-xchange@email.1und1.de>
 <1481095953.17027.0.camel@embedded.rocks>
 <123257138.400786.e58aee3b-9fc2-4b39-a030-c2409c5b92fc.open-xchange@email.1und1.de>
 <1481706204.3994.4.camel@embedded.rocks>
 <962480933.163666.1481741832090@email.1und1.de>
Message-ID: <1481809814.29241.2.camel@embedded.rocks>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Wed, 2016-12-14 at 19:57 +0100, Stefan Wahren wrote:
> Hi J?rg,
> 

[snip]

> > > 
> > > did you try cyclictest [1]?
> > 
> > Not yet. Not sure what to measure and which values to compare here.
> 
> i tought you have the vendor kernel and the mainline kernel available
> for your platform.
> 
> So you could compare the both kernels.

Yes, that's right. I will have a look at this tool.

> > 
> > > 
> > > Beside the time for a request the amount of requests for the
> > > complete
> > > iperf test
> > > would we interesting. Maybe there are retries.
> > > 
> > > I'm still interested in your PIO mode patches for mxs-mmc even
> > > without clean up.
> > 
> > Actually, the patch does not implement a PIO mode, but drops DMA
> > and
> > uses polling instead. I've attached the patch.
> 
> Thanks. I applied it, but unfortunately this breaks SD card support
> for my Duckbill and the kernel isn't able to mount the rootfs:
> 
> [????2.267073] mxs-mmc 80010000.ssp: initialized
> [????2.272624] mxs-mmc 80010000.ssp: AC command error 0xffffff92

Sorry, I messed up the branches. I attached the correct patch which is
working for me on Linux v4.9.

J?rg
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0200-mmc-mxs-mmc-use-PIO-mode.patch
Type: text/x-patch
Size: 15450 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161215/b5c33807/attachment-0001.bin>
