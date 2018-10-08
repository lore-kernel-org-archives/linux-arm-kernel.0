From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Mon, 08 Oct 2018 16:28:41 +0200
Subject: [PATCH v2 10/29] drm/sun4i: Rename DE2 registers related macros
In-Reply-To: <20181008101828.hb4xtppbexwalbkk@flea>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-11-jernej.skrabec@siol.net>
 <20181008101828.hb4xtppbexwalbkk@flea>
Message-ID: <11072788.dZi9MDiihb@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ponedeljek, 08. oktober 2018 ob 12:18:28 CEST je Maxime Ripard napisal(a):
> Hi,
> 
> On Sun, Oct 07, 2018 at 11:38:46AM +0200, Jernej Skrabec wrote:
> > In preparation to introduce DE3 support, change prefix from "SUN8I_" to
> > "DE2_". Current prefix suggest that it's valid only for one family,
> > whereas in reality, DE2 unit is used also on sun50i family.
> > Additionally, it will be easier to distinguish DE3 specific macros by
> > using "DE3_" prefix.
> > 
> > No functional change in this commit.
> 
> I'm not too sure about this one. There's basically two ways to look at
> this: you described the first one, and the second one would be to
> treat it as we do for the compatibles: the IP was introduced on one
> SoC family, and then got used on some other ones.
> 
> Trying to always match the one you have however have a quite big
> maintainance cost, as can be shown by your patch: you always have to
> adapt comments, function names, defines, etc. This creates a lot of
> useless churns (ie, non-functional changes) in the drivers, that need
> to be written in the first place, and then reviewed.
> 
> It's just not worth it.

Well, using family neutral way would mean that there is no need anymore for 
adaptation in the future, but as you wish.

What prefix should I use for DE3 specific registers?

Best regards,
Jernej
