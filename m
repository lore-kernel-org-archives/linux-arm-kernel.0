From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 02 Mar 2013 20:05:24 +0000
Subject: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
In-Reply-To: <512D3EC2.6050408@ti.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <1329321854-24490-4-git-send-email-b-cousson@ti.com>
 <4F44FA56.7020000@gmail.com> <4F44FC37.2000701@ti.com>
 <4F452484.5080503@gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com>
 <4F47AD08.4030504@ti.com>
 <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com>
 <512D39DA.7020306@ti.com> <512D3AB1.1080202@wwwdotorg.org>
 <512D3EC2.6050408@ti.com>
Message-ID: <20130302200524.D230F3E1571@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Feb 2013 17:01:22 -0600, Jon Hunter <jon-hunter@ti.com> wrote:
> 
> On 02/26/2013 04:44 PM, Stephen Warren wrote:
> > On 02/26/2013 03:40 PM, Jon Hunter wrote:
> >> On 02/26/2013 04:01 AM, Javier Martinez Canillas wrote:
> >> Are you requesting the gpio anywhere? If not then this is not going to
> >> work as-is. This was discussed fairly recently [1] and the conclusion
> >> was that the gpio needs to be requested before we can use as an interrupt.
> > 
> > That seems wrong; the GPIO/IRQ driver should handle this internally. The
> > Ethernet driver shouldn't know/care whether the interrupt it's given is
> > some form of dedicated interrupt or a GPIO-based interrupt, and even if
> > it somehow did, there's no irq_to_gpio() any more, so the driver can't
> > tell which GPIO ID it should request, unless it's given yet another
> > property to represent this.
> 
> I agree that ideally this should be handled internally. Did you read the
> discussion on the thread that I referenced [1]? If you have any thoughts
> we are open to ideas :-)

I'm on an airplane right now, but I agree 100% with Stephen. I'll try to
remember to go read that thread and respond, but this falls firmly in
the its-a-bug category for me.  :-)

g.
