From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 12 Jun 2013 00:14:49 +0200
Subject: [RFC/PATCH v2 0/2] R-Car GPIO DT bindings
In-Reply-To: <20130525012434.GA24005@verge.net.au>
References: <1369136406-23800-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20130525012434.GA24005@verge.net.au>
Message-ID: <3619797.0aKKBP4JP5@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Saturday 25 May 2013 10:24:34 Simon Horman wrote:
> On Tue, May 21, 2013 at 01:40:04PM +0200, Laurent Pinchart wrote:
> > Hello,
> > 
> > Here's the second version of the gpio-rcar driver DT bindings. I've tested
> > the patches on the Marzen board (r8a7779).
> > 
> > Once again I'd appreciate feedback on the DT bindings. I'm particularly
> > wondering whether getting the number of lines through the gpio-ranges
> > property instead of using a dedicated #gpio-lines property as in v1 is a
> > good idea.
> > 
> > Changes since v1:
> > 
> > - Initialize the gpiochip dev field at probe time.
> > - Add the gpio-ranges property.
> > - Remove the #gpio-lines property. The number of lines is now passed
> > through> 
> >   the gpio-ranges property.
> > 
> > Laurent Pinchart (2):
> >   gpio-rcar: Make the platform data gpio_base field signed
> >   gpio-rcar: Add DT support
> >  
> >  .../devicetree/bindings/gpio/renesas,gpio-rcar.txt | 52 +++++++++++++++++
> >  drivers/gpio/gpio-rcar.c                           | 66 +++++++++++++----
> >  include/linux/platform_data/gpio-rcar.h            |  2 +-
> >  3 files changed, 109 insertions(+), 11 deletions(-)
> >  create mode 100644
> >  Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
>
> Hi Magnus,
> 
> could you please review these changes?

I've received Magnus' ack face-to-face last week. I'm not sure whether that's 
a proper procedure, but I'm sure he will confirm that if needed.

Could you please take the patch in your tree for v3.11 ?

-- 
Regards,

Laurent Pinchart
