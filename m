From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 5 Nov 2013 22:56:58 +0100 (CET)
Subject: [PATCH] ARM: pcm037: convert custom GPIO-based power function
 to a regulator
In-Reply-To: <20131104084047.GR24559@pengutronix.de>
References: <Pine.LNX.4.64.1310311118370.30523@axis700.grange>
 <20131104084047.GR24559@pengutronix.de>
Message-ID: <Pine.LNX.4.64.1311052252340.3700@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, 4 Nov 2013, Sascha Hauer wrote:

> Hi Guennadi,
> 
> On Thu, Oct 31, 2013 at 11:20:46AM +0100, Guennadi Liakhovetski wrote:
> > Add a fixed-voltage GPIO-enabled regulator to switch the camera on and off
> > instead of using a .power() platform callback.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > 
> > Only tested to grab the regulator during probing, couldn't test 
> > functionality due to the lack of an mt9t031 sensor.
> > 
> >  arch/arm/mach-imx/mach-pcm037.c |   50 ++++++++++++++++++++++++++++-----------
> >  1 files changed, 36 insertions(+), 14 deletions(-)
> 
> What's the motivation for this patch? It probably does the right thing,
> but I think we need a plan for converting this to devicetree rather than
> adding more stuff.

It's not adding stuff. It's getting rid of a custom callback and replacing 
it with a proper regulator. Sure, if there's a plan to port this platform 
to DT in a foreseeable future - feel free to drop this. But such a port 
would require adding DT support to the mx3_camera driver / the soc-camera 
framework, which might take some time, and this board isn't too new 
either, so, maybe not many customers will be prepared to pay for that kind 
of work ;) Anyway, I find this useful in its present form, but if there 
are plans to switch to DT soon enough - no problem with dropping it 
either.

Thanks
Guennadi

> Sascha

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
