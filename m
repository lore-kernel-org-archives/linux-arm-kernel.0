From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 04 Mar 2016 17:18:23 +0100
Subject: [PATCH 2/2] isdn: i4l: move active-isdn drivers to staging
In-Reply-To: <1659125.tHp8H942OG@wuerfel>
References: <1456945629-1793533-1-git-send-email-arnd@arndb.de>
 <1456945629-1793533-2-git-send-email-arnd@arndb.de>
 <56D7F62E.6050502@linux-pingi.de> <1659125.tHp8H942OG@wuerfel>
Message-ID: <1457108303.2651.112.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Added Tilman and Christoph.]

On vr, 2016-03-04 at 16:24 +0100, Arnd Bergmann wrote:
> I actually did more patches that I ended up not submitting:
> 
> * move hisax to staging
> * remove i4l support from gigaset

For the record: I have no reason to object a patch that does that. (I'm
not aware anyone complained when gigaset switched its default from i4l
to capi. By now all relevant distributions should use our capi driver.)

> * move i4l core to staging

On a local tree I have two (draft) patches that do some related
preliminary work:
- isdnhdlc: move into separate directory
- mISDN: NETJet: stop selecting ISDN_I4L

These trivial patches untangle mISDN and i4l. Perhaps you did something
similar in your "move i4l core to staging".

> while I initially thought that i4l as a whole is not just unmaintained
> but also more or less unused, patch 19cebbcb04c8 ("isdn: Partially
> revert debug format string usage clean up") came in that indicated
> that
> there are still users that even send patches for hisax, and that
> made me doubt whether we could consider it obsolete enough.

See also commit 3460baa62068 ("PCI: Fix minimum allocation address
overwrite").

> Any thoughts on this? If you like, I can send those too.

For my part I'm surprised that anyone is still using it. But apparently
the hardware that required commit 19cebbcb04c8 and 3460baa62068  (which
I'm unfamiliar with) is still operational. And since there never has
been, as far as I know, a global i4l to capi migration nor a global i4l
(and capi) to mISDN migration it might be that some people are stuck on
i4l drivers for their hardware. Perhaps that explains Cristoph's
commits.

> My main motivation was to not have to fix up the ippp implementation
> when I move the compat ioctl handler from fs/compat_ioctl.c
> into drivers/net/ppp/ppp_generic.c, but I guess I can do that
> anyway as it seems that i4l never worked properly in compat mode.


Paul Bolle
