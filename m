From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 20 Mar 2014 16:39:20 -0700
Subject: [stable 3.10.y] Please backport a56a5cf1f2ec "ARM: highbank:
 avoid L2 cache smc calls when PL310 is not present"
In-Reply-To: <1395310200.16974.35.camel@kazak.uk.xensource.com>
References: <1394332548.13270.74.camel@hastur.hellion.org.uk>
 <20140319235425.GA22080@kroah.com>
 <1395310200.16974.35.camel@kazak.uk.xensource.com>
Message-ID: <20140320233920.GD24571@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 10:10:00AM +0000, Ian Campbell wrote:
> On Wed, 2014-03-19 at 23:54 +0000, Greg KH wrote:
> > On Sun, Mar 09, 2014 at 02:35:48AM +0000, Ian Campbell wrote:
> [...]
> > > I thought it might require 0b53c11d533a "ARM: move outer_cache
> > [...] 
> > > commit a56a5cf1f2ec895599eace0ac6eba1e4a489e4bf
> 
> > This doesn't apply to the 3.10 stable tree, so if you want it there, can
> > you provide a backported version?
> 
> Strange, they both cherry-picked cleanly onto v3.10.33 for me. I've
> pushed the resulting tree.
> 
> The following changes since commit 6969595f011b46b49c3f1b9e0bd7da27768c1fd9:
> 
>   Linux 3.10.33 (2014-03-06 21:58:45 -0800)
> 
> are available in the git repository at:
> 
>   git://xenbits.xen.org/people/ianc/linux.git for-greg/3.10.y-arm-smc-backport
> 
> for you to fetch changes up to ac416026f5abb1da41b19ea725f5c1a114702756:
> 
>   ARM: highbank: avoid L2 cache smc calls when PL310 is not present (2014-03-20 10:07:22 +0000)
> 
> ----------------------------------------------------------------
> Rob Herring (2):
>       ARM: move outer_cache declaration out of ifdef
>       ARM: highbank: avoid L2 cache smc calls when PL310 is not present
> 
>  arch/arm/include/asm/outercache.h |    4 ++--
>  arch/arm/mach-highbank/highbank.c |   13 ++++++-------
>  2 files changed, 8 insertions(+), 9 deletions(-)

Can you just email these to me, I can't easily take git pulls for stable
patches, sorry.

greg k-h
