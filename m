From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 8 Jul 2014 10:08:14 +0200
Subject: [PATCH 05/18] power: reset: Add AT91 reset driver
In-Reply-To: <20140707184001.GH9558@ns203013.ovh.net>
References: <1404396906-25194-1-git-send-email-maxime.ripard@free-electrons.com>
 <1404396906-25194-8-git-send-email-maxime.ripard@free-electrons.com>
 <F9547E0F-AB97-47E6-BA09-135EE4E1BC73@jcrosoft.com>
 <20140703145957.GH31996@lukather>
 <B425B925-B75E-4761-8CE6-9B12C5AC0469@jcrosoft.com>
 <20140704091443.545d1e08@bbrezillon>
 <20140704090645.GB13487@lukather>
 <20140707184001.GH9558@ns203013.ovh.net>
Message-ID: <20140708080814.GL13423@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 08:40:01PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > >> move this to an assembly file more easy to read than a C code
> > > > > 
> > > > > Nope. It's a pain to pass variable to an external assembly file, and
> > > > > this makes the use of global variable pretty much mandatory, which is
> > > > > definitely not great.
> > > > 
> > > > Not at all I did for the PM slow clock code just write a function and pas it as a parameter
> > > > you have 3
> > > > 
> > > > so basically you have to use the current and just pass at91_ramc_base[0], at91_ramc_base[1]
> > > > and at91_rstc_base
> > > > it?s 3 lignes of modification, if you have at91_ramc_base and at91_ramc_base same
> > > > 
> > > 
> > > Yes, retrieving function parameters from assembly code is not that
> > > complicated (the first 4 pointer values are accessible through r0-r3),
> > > but then you'll have to store your assembly file somewhere.
> > 
> > Like I was saying, there's a strong preference for the inline
> > assembly...
> 
> inline is horrible to read and maintain NACK
> 
> keep it in an assembly file it's so easy to read and follow
> 
> and you just have to move the file existing to the driver/power

Well, the whole rest of the kernel community feels otherwise.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140708/c2c7ed1d/attachment.sig>
