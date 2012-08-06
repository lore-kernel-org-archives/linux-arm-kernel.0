From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 06 Aug 2012 18:36:10 -0400 (EDT)
Subject: kernel entry for thumb2-only cpus
In-Reply-To: <CAKGA1b=hMZD3nd2sjXzR89-wX4BotxZwHOkkiLFoEL_CSS4zug@mail.gmail.com>
References: <20120803090452.GE2626@pengutronix.de>
 <20120803114532.GB26925@mudshark.cambridge.arm.com>
 <20120805095528.GO2626@pengutronix.de>
 <alpine.LFD.2.02.1208060026460.5231@xanadu.home>
 <CAKGA1b=Pxif=4qSvK-Odmunbm_T6LjWP_CXid_v2VNmpuyHLDA@mail.gmail.com>
 <20120806190856.GA1120@n2100.arm.linux.org.uk>
 <CAKGA1b=Np8+RMwgQEzwxdJcL6AjC4qiv1Jyq0bTTa_dHCeLokA@mail.gmail.com>
 <20120806194016.GB1120@n2100.arm.linux.org.uk>
 <CAKGA1b=hMZD3nd2sjXzR89-wX4BotxZwHOkkiLFoEL_CSS4zug@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1208061829510.5231@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Aug 2012, Matt Sealey wrote:

> Right now there's already a fixed entry point - ARM kernels are fixed
> entry point of relative 0 to the start of the loaded image. Okay, so
> we can't format a totally valid ELF header, but in the event that we
> want to encode all this information yet again, why reinvent the wheel?

That's the point.  We do _not_ want to encode anything.

By convention, if your CPU is ARM mode capable, then it must call the 
kernel in ARM mode, period.  Can't be simpler than that, right?  The 
bootloader shouldn't care if the kernel is itself ARM or Thumb, and the 
kernel shouldn't care if the bootloader is ARM or Thumb.

If you have a real problem with this then let's hear it so it can be 
addressed.


Nicolas
