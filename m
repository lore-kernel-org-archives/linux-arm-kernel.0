From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 26 Jun 2014 13:49:09 +0300
Subject: [PATCH] clk: define and export __clk_get_debug for providers
In-Reply-To: <44039675.8s16pHQIVH@wuerfel>
References: <1403713591-17179-1-git-send-email-pdeschrijver@nvidia.com>
 <44039675.8s16pHQIVH@wuerfel>
Message-ID: <20140626104909.GD3679@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 08:07:37PM +0200, Arnd Bergmann wrote:
> On Wednesday 25 June 2014 19:26:31 Peter De Schrijver wrote:
> > Define and export a new function __clk_get_debug which returns the debugfs
> > directory entry pointer. This can be used by clock providers to add debugfs
> > entries which are not related to a specific clock type. Examples include the
> > ability to measure the rate of a clock. It can also be used by modules to
> > create new debugfs entries. This is useful if you want to expose features
> > for testing which can potentially cause system instability such as allowing
> > to change a clock's rate from userspace.
> > 
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > 
> 
> Just an idea, but would it be better to add a pair of functions to add/remove
> debugfs files rather than exposing the dentry itself?
> 

Ok. Will do that.

Cheers,

Peter.
