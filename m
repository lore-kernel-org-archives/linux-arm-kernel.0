From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Thu, 29 Jun 2017 18:23:36 +0200
Subject: [PATCH v2] arm64: fix missing __user in compat_vfp_set()
In-Reply-To: <20170629142943.GA3966@e103592.cambridge.arm.com>
References: <20170628145816.24807-1-luc.vanoostenryck@gmail.com>
 <20170629100418.GC14607@arm.com>
 <20170629142447.juiwwut4yhfsdbmo@ltop.local>
 <20170629142943.GA3966@e103592.cambridge.arm.com>
Message-ID: <20170629162335.kce53hnwdbk3xyvq@ltop.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 03:34:06PM +0100, Dave Martin wrote:
> On Thu, Jun 29, 2017 at 04:24:48PM +0200, Luc Van Oostenryck wrote:
> > compat_vfp_set() is a helper writting some values via put_user()
> > and put_user() need a pointer annotated with '__user'.
> > The buffer used by the helper is correctly annotated with '__user'
> > but need to be casted to a real type before being given to
> > put_user().
> > 
> > The problem is that this cast lack a '__user' annotation.
> > 
> > Fix this by adding the missing '__user'.
> > 
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> 
> Apologies, I has half a reply written and then realised this issue was
> less straightforward that I first thought.  I have an alternate patch,
> see [1].

Ah yes.
I saw the now asymmetry between the set/copyout and the set/copyin
and I was a bit surprised by it.

Your new version look better (but I can't judge more than the look).

-- Luc
