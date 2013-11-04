From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 4 Nov 2013 09:40:47 +0100
Subject: [PATCH] ARM: pcm037: convert custom GPIO-based power function to
 a regulator
In-Reply-To: <Pine.LNX.4.64.1310311118370.30523@axis700.grange>
References: <Pine.LNX.4.64.1310311118370.30523@axis700.grange>
Message-ID: <20131104084047.GR24559@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

On Thu, Oct 31, 2013 at 11:20:46AM +0100, Guennadi Liakhovetski wrote:
> Add a fixed-voltage GPIO-enabled regulator to switch the camera on and off
> instead of using a .power() platform callback.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Only tested to grab the regulator during probing, couldn't test 
> functionality due to the lack of an mt9t031 sensor.
> 
>  arch/arm/mach-imx/mach-pcm037.c |   50 ++++++++++++++++++++++++++++-----------
>  1 files changed, 36 insertions(+), 14 deletions(-)

What's the motivation for this patch? It probably does the right thing,
but I think we need a plan for converting this to devicetree rather than
adding more stuff.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
