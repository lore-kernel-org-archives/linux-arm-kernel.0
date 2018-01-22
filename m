From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Jan 2018 11:13:38 +0100
Subject: Sunxi display white flash
In-Reply-To: <cd353e6a-685f-904e-beb6-f56a905f0ae9@micronovasrl.com>
References: <cd353e6a-685f-904e-beb6-f56a905f0ae9@micronovasrl.com>
Message-ID: <20180122101338.3u77ozjwgm6q7bpy@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 19, 2018 at 11:55:42PM +0100, Giulio Benetti wrote:
> I was wondering if it does make sense to reset TCON during
> sun4i_tcon_bind.

In theory, yes, we should remove it.

> What I experience is a screen white flash, this is because uboot
> already initialized display and enabled backlight.
> 
> IMHO, I would make TCON total reinit selectable via Kconfig and
> enabled by default, even if I don't like at all not to reset
> peripheral before using it, and assuming uboot did it for us before.
> 
> What do you think?  Do you have some other idea to workaround this?
> 
> Maybe checking if peripheral has already been set before, if Yes,
> avoid to reinit it.  Could it make sense?

And this makes a lot of sense. Except that you need to recreate the
whole DRM state from the TCON, HDMI and backend registers in order to
work properly. This is definitely something we can do at some point,
but it's also a quite huge amount of work.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180122/c524bd77/attachment.sig>
