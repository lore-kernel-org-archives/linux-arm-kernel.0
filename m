From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 18 Oct 2018 20:04:26 +0200 (CEST)
Subject: DMA configuration in non-DT probed driver
In-Reply-To: <839aa8cf-aabe-c087-4d35-c1a96bbf3f13@arm.com>
References: <18dfef35-54f6-0e45-ff8e-f0c3e70b8580@i2se.com>
 <839aa8cf-aabe-c087-4d35-c1a96bbf3f13@arm.com>
Message-ID: <469006239.132128.1539885866203@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Robin Murphy <robin.murphy@arm.com> hat am 18. Oktober 2018 um 15:35 geschrieben:
> 
> 
> If you consider the VCHIQ node to represent "stuff the VC4 does" and 
> don't want to go to a full-blown "devices owned by VC4" bus_type 
> implementation similar to Host1x, then given that in practice you've got 
> a pretty simple interconnect topology I reckon it's fair and 
> sufficiently accurate for the VCHIQ driver to configure 
> dynamically-created devices based on its own node, i.e. something like:
> 
> 	child_dev = platform_device_alloc(...)
> 	of_dma_configure(&child_dev->dev, vchiq_dev->of_node, ...);
> 	platform_device_add(child_dev);
> 
> (the configuration wants to be done before anything which could trigger 
> driver probing to avoid any possibility of awkward races)
> 
> You could *almost* just set child_dev's of_node and let 
> platform_dma_configure() take care of the rest, but unfortunately I 
> think that probably breaks driver matching.

Thank you very much
