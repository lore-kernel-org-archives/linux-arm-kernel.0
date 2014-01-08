From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 8 Jan 2014 19:58:37 +0100
Subject: [ANNOUNCE] sunxi-babelfish (FEX-to-DT translator)
In-Reply-To: <201401081402.22036.arnd@arndb.de>
References: <20140107220310.GD3103@lukather> <201401081402.22036.arnd@arndb.de>
Message-ID: <20140108185837.GI2941@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, Jan 08, 2014 at 02:02:21PM +0100, Arnd Bergmann wrote:
> On Tuesday 07 January 2014, Maxime Ripard wrote:
> 
> > Anyway, enough talking. Any feedback is, as usual, appreciated.
> 
> I think it's a pretty cool idea. Have you considered integrating this with
> the impedence-matcher project at
> 
> https://github.com/zonque/pxa-impedance-matcher ?
> 
> That one basically does the same thing for atags-based boot loaders and I
> would guess that parts of the implementation can be shared as well, plus
> the combination could support a wider range of devices.

Yep, I've considered it at first. Actually, I even took some bits out
of it to use them.

But I thought this would be too far off the pxa-impedance-matcher to
bother trying to fit it in. IIRC, pxa-impedance-matcher is taking the
mach-id (mostly) to take an already existing DT and give it to the
kernel, while we have pretty much the opposite where we have a generic
mach-id, and build up the DTB from another source of information.

I also integrated some fexc bits to be able to parse the script.bin
file, which is highly sunxi specific.

But if Daniel's interested in merging all of this, I can totally
consider it more seriously.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/bd63bdf9/attachment.sig>
