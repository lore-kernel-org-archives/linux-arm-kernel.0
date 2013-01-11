From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 11 Jan 2013 19:39:49 +0000
Subject: [PATCH 0/2 v2] at91/ssc: fixes on ASoC tree for 3.8
In-Reply-To: <CAOesGMhhSkrvP7X=y8qmdMKKXZ694+1+ZXY3y6HK1E85qaN5sQ@mail.gmail.com>
References: <cover.1357912706.git.nicolas.ferre@atmel.com>
 <CAOesGMhhSkrvP7X=y8qmdMKKXZ694+1+ZXY3y6HK1E85qaN5sQ@mail.gmail.com>
Message-ID: <20130111193948.GA8677@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 10:52:19AM -0800, Olof Johansson wrote:
> On Fri, Jan 11, 2013 at 6:08 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> 
> > This material was designed to enter Mark's fixes queue, but as discussed with
> > Olof, we can imagine merging everything through arm-soc or split the series (of
> > 2 patches) and let them progress upstream separated (option that I do not like
> > even if I know that the consequences are not so dramatic).
> > So please, Olof, if you feel confortable with this series, tell us what you
> > prefer and we will make our best to make this material go forward...

> You're setting yourself up for awkward merges. The driver change is
> strongly dependent on the device tree change by failing probe unless
> the device tree update is there, while before this patch, it still
> worked.

This is partly my fault for getting grumpy about adding the bolier plate
code without error checking - overall Linus' change to do the get in the
core seems like the most sane approach here.

> But to be honest, I don't think this is a fix, it's a feature that you
> just didn't include in time for the merge window. I don't really see
> them as appropriate 3.8 material at this point.

Jean-Christophe has been most insistent that pinctrl support is now
manadatory for all AT91 systems using device tree.  Unfortunately
pinctrl support for AT91 only came in during the merge window and it
seems like it's sadly been impossible to do what seemd like the obvious
thing and add the pinctrl bindings to the DT prior to the merge down so
now we've got this mess.  I believe the way the pinctrl conversion was
done renders the audio driver non-functional without this series.

> So, nack on this series. Please make the driver change non-dependent
> on the new dtsi contents, and merge that through the ASoC tree. Then
> the dtsi update can go through arm-soc, and later on you can make it
> mandatory.

Like I say I'm not thrilled about ignoring the return code TBH, nor am I
thrilled with the way this has been handled overall.  That said, the
current series does seem like the best of a bad job - as I understand it
we need something like this in v3.8 to make the driver functional.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130111/3d4e2769/attachment-0001.sig>
