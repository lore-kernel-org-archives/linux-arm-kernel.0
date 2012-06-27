From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 27 Jun 2012 14:24:56 +0800
Subject: [PATCH v7 01/14] usb: chipidea: remove unneeded NULL check
In-Reply-To: <20120626214311.GA4878@kroah.com>
References: <1340607391-16380-1-git-send-email-richard.zhao@freescale.com>
 <1340607391-16380-2-git-send-email-richard.zhao@freescale.com>
 <20120626214311.GA4878@kroah.com>
Message-ID: <20120627062455.GC21750@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 02:43:11PM -0700, Greg KH wrote:
> On Mon, Jun 25, 2012 at 02:56:18PM +0800, Richard Zhao wrote:
> > From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > 
> > As reported by Dan Carpenter, there is a NULL check in udc_start() that
> > follows a dereference of the pointer that's being checked. However, at
> > that point udc pointer shouldn't ever be NULL and if it is, the dereference
> > should cause an oops.
> > 
> > Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Acked-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/usb/chipidea/udc.c |    3 ---
> >  1 file changed, 3 deletions(-)
> 
> First comment, you send a bunch of patches, yet you didn't sign off on
> some of them, why?  If you are forwarding on patches, please sign off
> showing you have reviewed them (so you can be on the path-of-blame if
> there is a problem...)
You're right :)
> 
> There has been some discussion on some of these patches, so I'm guessing
> we need a v8 set of this series at the least?
Yes.

Thanks
Richard
> 
> thanks,
> 
> greg k-h
> 
