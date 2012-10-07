From: cavokz@gmail.com (Domenico Andreoli)
Date: Sun, 7 Oct 2012 12:14:18 +0200
Subject: [PATCH 0/6] ARM: Add support for Broadcom BCM476x SoCs
In-Reply-To: <5071118A.6040508@wwwdotorg.org>
References: <20121007015300.828366635@gmail.com>
 <5071118A.6040508@wwwdotorg.org>
Message-ID: <20121007101418.GA24323@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 06, 2012 at 11:22:18PM -0600, Stephen Warren wrote:
> On 10/06/2012 07:53 PM, Domenico Andreoli wrote:
> > 
> > Additional support is being worked on.... and usb (DWC OTG) only
> > attemped reusing s3c-hsotg.
> 
> Hmmm. I believe the bcm2835 uses DWC OTG. I wonder if the same driver
> will work there; USB in particular is a major pain point on the bcm2835...

I don't know any more how many versions of this driver are circulating,
we may have some options.

> > It's based on a random pre v3.7-rc1 commit (eb0ad9c) with mainlined
> > multi-platform support and Stephen's patch to add DEBUG_LL to it.
> 
> ...
> about uncompress.h now. Unless anyone really pipes up and says they'd
> still like me to pursue uncompress.h in multi-platform, I'm inclined to
> drop it.

I think it is valuable, multi-platform doesn't have any DEBUG_LL or
earlyprintk support and your patch solves the problem though it won't
work transparently on multiple boards at the same time, which is not
a requirement.

To my understanding Nico was complaining for the specific Tegra (and TI)
abuse, not the general approach.

> > Special thanks go to Stephen Warren who, with the recently mainlined
> > BCM2835, showed how to do things cleanly since the beginning and
> > involuntarily spurred me to act.
> 
> Thanks! Do note that much of the code I upstreamed was originally
> written by others, although I did make quite a few changes during
> upstream submission.

Yes, of course :)

Regards,
Domenico
