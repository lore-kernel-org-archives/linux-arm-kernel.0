From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 26 Jun 2014 13:32:09 +0300
Subject: [PATCH] clk: define and export __clk_get_debug for providers
In-Reply-To: <20140625182349.32686.25931@quantum>
References: <1403713591-17179-1-git-send-email-pdeschrijver@nvidia.com>
 <44039675.8s16pHQIVH@wuerfel> <20140625182349.32686.25931@quantum>
Message-ID: <20140626103209.GC3679@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 08:23:49PM +0200, Mike Turquette wrote:
> Quoting Arnd Bergmann (2014-06-25 11:07:37)
> > On Wednesday 25 June 2014 19:26:31 Peter De Schrijver wrote:
> > > Define and export a new function __clk_get_debug which returns the debugfs
> > > directory entry pointer. This can be used by clock providers to add debugfs
> > > entries which are not related to a specific clock type. Examples include the
> > > ability to measure the rate of a clock. It can also be used by modules to
> > > create new debugfs entries. This is useful if you want to expose features
> > > for testing which can potentially cause system instability such as allowing
> > > to change a clock's rate from userspace.
> > > 
> > > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > > 
> > 
> > Just an idea, but would it be better to add a pair of functions to add/remove
> > debugfs files rather than exposing the dentry itself?
> 
> Arnd,
> 
> Yes, accessor functions are much better than exposing struct clk
> internals.
> 
> Peter,
> 
> Just FYI, I'm trying to reverse the trend of prepending double
> underscores for functions that are used by clock providers. That stuff
> started out small and sort of grew out of control ;-)
> 

Ah. I was just following the existing pattern here :)

Cheers,

Peter.
