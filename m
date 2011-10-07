From: Valdis.Kletnieks@vt.edu (Valdis.Kletnieks at vt.edu)
Date: Fri, 07 Oct 2011 19:28:33 -0400
Subject: [PATCH 1/5] drivercore: add new error value for deferred probe
In-Reply-To: Your message of "Fri, 07 Oct 2011 16:12:45 MDT."
	<CACxGe6uOmrLwJSPw4JHuOmt5B2wsukdDgVUr01pryq5Z9BFadw@mail.gmail.com>
References: <1317963790-29426-1-git-send-email-manjugk@ti.com>
	<1317963790-29426-2-git-send-email-manjugk@ti.com>
	<20111007064349.GD27508@kroah.com>
	<CACxGe6uOmrLwJSPw4JHuOmt5B2wsukdDgVUr01pryq5Z9BFadw@mail.gmail.com>
Message-ID: <32004.1318030113@turing-police.cc.vt.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 07 Oct 2011 16:12:45 MDT, Grant Likely said:
> On Fri, Oct 7, 2011 at 12:43 AM, Greg KH <greg@kroah.com> wrote:
> > On Fri, Oct 07, 2011 at 10:33:06AM +0500, G, Manjunath Kondaiah wrote:

> >> +#define EPROBE_DEFER 517 ? ? /* restart probe again after some time */
> >
> > Can we really do this?

> According to Arnd, yes this is okay.

> > ?Isn't this some user/kernel api here?

> > What's wrong with just "overloading" on top of an existing error code?
> > Surely one of the other 516 types could be used here, right?

> overloading makes it really hard to find the users at a later date.

Would proposing '#define EPROBE_DEFER EAGAIN' be acceptable to everybody? That
would allow overloading EAGAIN, but still make it easy to tell the usages apart
if we need to separate them later...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 227 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111007/ed64fb47/attachment.sig>
