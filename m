From: simon.kagstrom@netinsight.net (Simon =?UTF-8?B?S8OlZ3N0csO2bQ==?=)
Date: Wed, 5 Mar 2014 11:07:10 +0100
Subject: [PATCH 2/2] ixp4xx_eth: Setup coherent_dma_mask
In-Reply-To: <m38uspas21.fsf@t19.piap.pl>
References: <20140305085311.07b3922a@marrow.netinsight.se>
 <20140305085549.3eb22236@marrow.netinsight.se>
 <m3d2i1atmq.fsf@t19.piap.pl>
 <20140305094330.GU21483@n2100.arm.linux.org.uk>
 <m38uspas21.fsf@t19.piap.pl>
Message-ID: <20140305110710.0e92f4ca@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 5 Mar 2014 10:55:02 +0100
Krzysztof Ha?asa <khalasa@piap.pl> wrote:

> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> > If you have drivers missing this call, that's part of the problem:
> >
> > | For correct operation, you must interrogate the kernel in your device
> > | probe routine to see if the DMA controller on the machine can properly
> > | support the DMA addressing limitation your device has.
> 
> Well, we already know it can. Actually, the DMA controller is a part of
> the CPU + RAM controller chip :-)
> 
> But I guess with this new wording it's something the drivers can use.

With that wording, I would say these two patches should be applicable:
The first corrects dma_set_coherent_mask() to actually setup the
coherent_dma_mask (and make it applicable outside of the PCI domain)
and the second sets it up in the driver, as per

> > | support the DMA addressing limitation your device has.  It is good
> > | style to do this even if your device holds the default setting,
> > | because this shows that you did think about these issues wrt. your
> > | device.

Without these patches (or Krzysztofs patch), the ixp4xx platform is
broken for many common configurations.

// Simon
