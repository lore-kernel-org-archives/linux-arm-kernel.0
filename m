From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 11 Jan 2013 21:36:10 +0100
Subject: [PATCH v2] drivers/pinctrl: grab default handles from device core
In-Reply-To: <CACRpkdZ0b=ZohgaBH3qPH_O5TiWmXJXs6872D+YPVA9g4BssYg@mail.gmail.com>
References: <1355343907-11535-1-git-send-email-linus.walleij@stericsson.com>
 <50EF27B4.60608@wwwdotorg.org>
 <CACRpkdZ0b=ZohgaBH3qPH_O5TiWmXJXs6872D+YPVA9g4BssYg@mail.gmail.com>
Message-ID: <9702060.jEbHySsCv0@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Friday 11 January 2013 21:12:43 Linus Walleij wrote:
> On Thu, Jan 10, 2013 at 9:42 PM, Stephen Warren wrote:
> > On 12/12/2012 01:25 PM, Linus Walleij wrote:
> >> From: Linus Walleij <linus.walleij@linaro.org>
> >> 
> >> This makes the device core auto-grab the pinctrl handle and set
> >> the "default" (PINCTRL_STATE_DEFAULT) state for every device
> >> that is present in the device model right before probe. This will
> >> account for the lion's share of embedded silicon devcies.
> > 
> > There are quite a few problems with this patch, and they end up
> > completely breaking at least Tegra in next-20130110.
> 
> But I have not put this patch into linux-next.
> 
> I was still waiting for Greg to ACK it...
> 
> Apparently it was included in a pull request to the SH tree or something,
> Simon can you remove these patches for now, this patch needs to
> be elaborated on in the pinctrl tree first.

I've sent several patch series for the SH PFC (Pin Function Controller) to the 
linux-sh mailing list. One of the series included pinctrl core patches for 
easier testing, but I made it clear that they should *not* be pushed to 
mainline through the SH tree.

Actually the whole PFC series have been found out today by Guennadi 
Liakhovetski to be buggy. I will fix the problems and send a new version. In 
the meantime the pinmux-pinctrl and pinmux-dt series should not be pushed to 
mainline.

-- 
Regards,

Laurent Pinchart
