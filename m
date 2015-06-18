From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Thu, 18 Jun 2015 21:49:05 +0530
Subject: [PATCH v2 5/7] samples: kdbus: disable for mn10300
In-Reply-To: <20150618143958.GA8830@kroah.com>
References: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1434629873-11668-6-git-send-email-sudipm.mukherjee@gmail.com>
 <20150618143958.GA8830@kroah.com>
Message-ID: <20150618161905.GB21198@sudip-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 07:39:58AM -0700, Greg Kroah-Hartman wrote:
> On Thu, Jun 18, 2015 at 05:47:51PM +0530, Sudip Mukherjee wrote:
> > While building it failed with:
> > In function 'prime_new':
> > error: '__NR_memfd_create' undeclared (first use in this function)
> > 
> > memfd_create syscall has not yet been implemented for mn10300.
> > so disable compilation of samples/kdbus for now with mn10300.
> > 
> > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > ---
> >  samples/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/samples/Kconfig b/samples/Kconfig
> > index a4c6b2f..20c55af 100644
> > --- a/samples/Kconfig
> > +++ b/samples/Kconfig
> > @@ -57,7 +57,7 @@ config SAMPLE_KDB
> >  
> >  config SAMPLE_KDBUS
> >  	bool "Build kdbus API example"
> > -	depends on KDBUS
> > +	depends on KDBUS && !MN10300
> 
> Why not just add the memfd syscall to this arch?
Yes, I intend to. But for now this will fix allmodconfig.
>I thought someone had already sent such a patch in a while ago.
Then it is still not merged. :(
I will try to find that patch adding memfd syscall. And if i find it whom
shall I forward it to?

regards
sudip
