From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 12 Feb 2013 20:52:29 +0100
Subject: [PATCH 12/17] ARM: fix magic for bootloader in BE8
In-Reply-To: <511A8FE6.1040801@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-13-git-send-email-ben.dooks@codethink.co.uk>
 <alpine.LFD.2.02.1302082304410.6300@xanadu.home>
 <20130209120823.GF17833@n2100.arm.linux.org.uk>
 <20130212185030.GK30595@game.jcrosoft.org>
 <511A8FE6.1040801@codethink.co.uk>
Message-ID: <20130212195229.GL30595@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:54 Tue 12 Feb     , Ben Dooks wrote:
> On 12/02/13 18:50, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >On 12:08 Sat 09 Feb     , Russell King - ARM Linux wrote:
> >>On Fri, Feb 08, 2013 at 11:06:55PM -0500, Nicolas Pitre wrote:
> >>>On Fri, 8 Feb 2013, Ben Dooks wrote:
> >>>
> >>>>If the boot-loader is running little endian and the kernel is compiled
> >>>>big endian then it will not verify the magic number of the front of the
> >>>>kernel.
> >>>>
> >>>>Note, do we need to also reverse the two values after the magic, or are
> >>>>they used later on in the kernel decompressor?
> >>>
> >>>Those value instances are not used by the code.  So for consistency they
> >>>would have to be reversed, yes.  Given those are variable and determined
> >>>by the linker, I don't know how you could manage it.
> >>
> >>Which is why I wish we never had them, they've got in the way before
> >>and they'll continue to do so.  I've seen boot loaders which do
> >>precisely the wrong thing with these too, and had to fight them for
> >>doing so.
> >in barebox we detect the type of file and detect we boot a zImage so be able
> >to detect we need to boot a be zImage is really appreciate
> >
> >so we do not ask user how to boot but handle it automaticly
> >
> >Best Regards,
> >J.
> 
> IIRC, IXP is BE32, not BE8 so this shouldn't affect it.
yes IXP is BE32
> 
> I'm removing this from the base patch-set anyway and considering
> making it conditional on the ATAGS endian-ness.
we need to be able to detect it that's all

Best Regards,
J.
> 
> -- 
> Ben Dooks				http://www.codethink.co.uk/
> Senior Engineer				Codethink - Providing Genius
