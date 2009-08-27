From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 27 Aug 2009 23:53:56 +0200 (CEST)
Subject: How to work out the cause of a DMA Bus Error (QCI PXA320)?
In-Reply-To: <20090827182308.19411cv37br99zvw@webmail.tu-cottbus.de>
References: <20090827182308.19411cv37br99zvw@webmail.tu-cottbus.de>
Message-ID: <Pine.LNX.4.64.0908272347140.4808@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Aug 2009, Judith Baumgarten wrote:

> Hi,
> 
> I'm still working on the pxa_camera driver for PXA320.

Is this a new driver or an extension to pxa270?

> At the moment I can
> capture some frames (RAW mode), but then I get a DMA Bus Error. Has anyone an
> idea how to deal with that error or work out the specific cause?
> The manual says, that if an error occures the channel is stopped until it's
> reprogrammed and the corresponding RUN bit is set, but there are no RUN bits
> in QCI DMA. So I don't see a chance to start it again...

I think we also had some DMA issues on pxa270, but we fixed them latest 
with these patches:

"V4L/DVB (11322): pxa_camera: Fix overrun condition on last buffer"
"V4L/DVB (11321): pxa_camera: Redesign DMA handling"

if you're writing a new driver, have a look t pxa270 and at those patches 
specifically.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
