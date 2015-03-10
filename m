From: balbi@ti.com (Felipe Balbi)
Date: Tue, 10 Mar 2015 16:23:53 -0500
Subject: [PATCH] udc: gadget: atmel_usba_udc: depend on COMMON_CLK_AT91
In-Reply-To: <20150310212122.GJ9188@piout.net>
References: <1425368567-5333-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150303092620.63e1861d@bbrezillon>
 <20150303094138.GC3892@piout.net>
 <20150310205312.GD18456@saruman.tx.rr.com>
 <20150310212122.GJ9188@piout.net>
Message-ID: <20150310212353.GI25666@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 10:21:22PM +0100, Alexandre Belloni wrote:
> On 10/03/2015 at 15:53:12 -0500, Felipe Balbi wrote :
> > On Tue, Mar 03, 2015 at 10:41:38AM +0100, Alexandre Belloni wrote:
> > > On 03/03/2015 at 09:26:20 +0100, Boris Brezillon wrote :
> > > > >  config USB_ATMEL_USBA
> > > > >  	tristate "Atmel USBA"
> > > > > -	depends on AVR32 || ARCH_AT91
> > > > > +	depends on AVR32 || ARCH_AT91 && COMMON_CLK_AT91
> > > > 
> > > > I guess you should add parenthesis to make it clearer ?
> > > > 
> > > > 	depends on AVR32 || (ARCH_AT91 && COMMON_CLK_AT91)
> > > > 
> > > > And I wonder why you need that. I though this option was selected by all
> > > > at91 platforms ?
> > > > 
> > > 
> > > That is currently the case but maybe, one day, one of the AT91 platform
> > > will not use the same clock driver.
> > 
> > then, maybe, one day, you send this patch.
> 
> Yeah, let's drop it for now but I have the feeling that this will
> break (I actually broke it when switching at91 to multiplatform).

aha, that changes it. So you already have something which makes this
break ? Are you planning on sending that upstream any time soon ?

We could very well use that same series to merge this patch. Only when
it's needed ;-)

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150310/88511924/attachment.sig>
