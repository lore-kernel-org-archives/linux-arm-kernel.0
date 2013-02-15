From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 15 Feb 2013 21:56:09 +0100
Subject: [PATCH] pinctrl: Declare operation structures as const
In-Reply-To: <CACRpkdaN+j+cV-=d-cDSw6aoq4Hh0Ary8wpAeYQU7wvpTAQgcQ@mail.gmail.com>
References: <1360939402-1170-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CACRpkdaN+j+cV-=d-cDSw6aoq4Hh0Ary8wpAeYQU7wvpTAQgcQ@mail.gmail.com>
Message-ID: <1952247.y2EsDpZE5I@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Friday 15 February 2013 21:51:51 Linus Walleij wrote:
> On Fri, Feb 15, 2013 at 3:43 PM, Laurent Pinchart wrote:
> > The pinconf, pinctrl and pinmux operation structures hold function
> > pointers that are never modified. Declare them as const.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Nice I love consting.
> 
> > This patch hasn't been compile-tested on all the above platforms,
> > Tested-by and/or Acked-by tags would thus be welcome.
> 
> I get this on all platforms after this patch:
> 
> /linux-pinctrl/drivers/pinctrl/pinconf.c: In function
> 'pinconf_dbg_config_print':
> /linux-pinctrl/drivers/pinctrl/pinconf.c:708:12: warning: assignment
> discards 'const' qualifier from pointer target type [enabled by
> default]
> 
> Pls fix! :-)

Hmmm... There's no pinconf_dbg_config_print() function in mainline. Where does 
it come from ?

> > I've left the sh-pfc driver untouched for now, it will be handled as part
> > as my next (hopefully soon to come) sh-pfc pinctrl series.
> 
> Sounds like a deal.

-- 
Regards,

Laurent Pinchart
