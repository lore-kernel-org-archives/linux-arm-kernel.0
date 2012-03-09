From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 09 Mar 2012 11:35:51 +0200
Subject: linux-next: manual merge of the arm-soc tree with the
 omap_dss2 tree
In-Reply-To: <201203081616.12510.arnd@arndb.de>
References: <20120308170048.f1a992bca2ca2d93fa9747bf@canb.auug.org.au>
 <201203081616.12510.arnd@arndb.de>
Message-ID: <1331285751.1927.20.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 2012-03-08 at 16:16 +0000, Arnd Bergmann wrote:
> On Thursday 08 March 2012, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the arm-soc tree got a conflict in
> > arch/arm/mach-omap1/board-palmtt.c between commit ddba6c7f7ec6 ("OMAP1:
> > pass LCD config with omapfb_set_lcd_config()") from the omap_dss2 tree
> > and commit 2e3ee9f45b3c ("ARM: OMAP1: Move most of plat/io.h into local
> > iomap.h") from the arm-soc tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary.
> 
> Hi Stephen,
> 
> Thanks for fixing up all the conflicts between arm-soc and omap_dss2.
> I think we should make sure they are resolved in one of the trees before
> the merge window.

Do we need to? The conflicts seemed to be trivial ones, like arm-soc
adds/removes something that just happens to be next to something else
that I add/remove.

My understanding is that it's better to leave those conflicts than to do
"trickery" to avoid them.

> Tomi, what are your plans for the omap_dss2 branch to get merged?

Normally my tree goes via fbdev-tree (Florian's tree) to mainline.

> Do you think you should send it to Linus first and we merge it into
> arm-soc to resolve the conflicts?
> Or do you want to merge it through the arm-soc tree?
> Or should we go first and you fix up the conflicts by pulling in the
> necessary topic branches from arm-soc into your tree?

If we want to resolve the conflicts, perhaps it's simplest if the dss
tree is merged to arm-soc.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120309/38627a82/attachment-0001.sig>
