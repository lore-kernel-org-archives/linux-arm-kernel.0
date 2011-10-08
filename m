From: greg@kroah.com (Greg KH)
Date: Fri, 7 Oct 2011 17:12:37 -0700
Subject: [PATCH 1/5] drivercore: add new error value for deferred probe
In-Reply-To: <32004.1318030113@turing-police.cc.vt.edu>
References: <1317963790-29426-1-git-send-email-manjugk@ti.com>
	<1317963790-29426-2-git-send-email-manjugk@ti.com>
	<20111007064349.GD27508@kroah.com>
	<CACxGe6uOmrLwJSPw4JHuOmt5B2wsukdDgVUr01pryq5Z9BFadw@mail.gmail.com>
	<32004.1318030113@turing-police.cc.vt.edu>
Message-ID: <20111008001237.GA30551@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2011 at 07:28:33PM -0400, Valdis.Kletnieks at vt.edu wrote:
> On Fri, 07 Oct 2011 16:12:45 MDT, Grant Likely said:
> > On Fri, Oct 7, 2011 at 12:43 AM, Greg KH <greg@kroah.com> wrote:
> > > On Fri, Oct 07, 2011 at 10:33:06AM +0500, G, Manjunath Kondaiah wrote:
> 
> > >> +#define EPROBE_DEFER 517 ? ? /* restart probe again after some time */
> > >
> > > Can we really do this?
> 
> > According to Arnd, yes this is okay.
> 
> > > ?Isn't this some user/kernel api here?
> 
> > > What's wrong with just "overloading" on top of an existing error code?
> > > Surely one of the other 516 types could be used here, right?
> 
> > overloading makes it really hard to find the users at a later date.
> 
> Would proposing '#define EPROBE_DEFER EAGAIN' be acceptable to everybody? That
> would allow overloading EAGAIN, but still make it easy to tell the usages apart
> if we need to separate them later...

Yes, please do that, it is what USB does for it's internal error code
handling.

greg k-h
