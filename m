From: matt.porter@linaro.org (Matt Porter)
Date: Wed, 23 Oct 2013 13:25:58 -0400
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131023171620.GA5208@netboy>
References: <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023094903.GD11954@ulmo.nvidia.com>
 <20131023171620.GA5208@netboy>
Message-ID: <20131023172558.GK29341@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 07:16:21PM +0200, Richard Cochran wrote:
> On Wed, Oct 23, 2013 at 11:49:04AM +0200, Thierry Reding wrote:
> > 
> > If a runtime warning isn't good enough, we can easily add a Kconfig
> > option too. If people want to test-drive new functionality and accept
> > that they might have to update the DTB even on a regular basis, they
> > could activate that option and use all supported devices, even those
> > with experimental bindings. Such an option could default to n, upon
> > which the OF core just wouldn't match anything that carries the
> > experimental marker.
> > 
> > Does that sound like a good compromise?
> 
> I think having a printk warning would be pointless because if the
> majority of ARM bindings are unstable as you say, then the average
> system will emit tons of them, encouraging people to just ignore them.
> 
> A kconfig option to allow unstable bindings seems okay to me in
> principle, as long as progress toward getting stable bindings
> continues. However, I expect that this option would become a "sticky
> bit" that is just left on forever (remember CONFIG_EXPERIMENTAL?).
> There would be little motivation for developers to ever get bindings
> into the "stable" category.
> 
> I still don't understand why someone (linario?) can't host an
> arm-dt-devel tree that allows the freedom to change bindings and
> features the best source for supporting the latest ARM SoCs. I don't
> buy the argument that only Linus' tree gets enough testing. If another
> tree really is the best ARM tree, then it will get plenty of attention
> and testing. Other people do this (for example, the TI arago tree),
> apparently with good success.

No, please, no!

Do not hold up TI's vendor tree as an example of success. We don't want
more vendor trees, we want less. Even TI knows that the vendor tree
model was a failure. All development will move there forever. If we lose
submit early and submit often we've completely failed.

"It's a trap!"

-Matt
