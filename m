From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 11 Nov 2013 10:14:53 +0100
Subject: [PATCH] arm,arm64: Conditionalize bio_vec usage
In-Reply-To: <CAOesGMjCeTeoF3M4UNY4zzAMyBFLddcwaXU91ur28hGca2uBHA@mail.gmail.com>
References: <1383743117-4138-1-git-send-email-treding@nvidia.com>
 <CAOesGMjCeTeoF3M4UNY4zzAMyBFLddcwaXU91ur28hGca2uBHA@mail.gmail.com>
Message-ID: <20131111091452.GE3884@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 07:40:43AM -0800, Olof Johansson wrote:
> On Wed, Nov 6, 2013 at 5:05 AM, Thierry Reding <thierry.reding@gmail.com> wrote:
> > Commit 3d1975b57097 (arm,arm64: do not always merge bio_vec if we are
> > running on Xen) unconditionally added code using the bio_vec typedefs
> > which causes build errors on configurations where CONFIG_BLOCK is
> > disabled.
> >
> > Add #ifdef CONFIG_BLOCK protection to fix this.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> 
> I commented on the offending patch (which is a good way to make people
> aware of it instead of posting standalone patches like you did),

The standalone patch got Stefano's attention, so I don't see why you
think it was a bad idea.

I don't expect such patches to always be applied as is. If they aren't
proper fixes and someone comes up with a much better way (which they did
in this case), then I'm just as happy. Also it actually takes about the
same amount of time to write up a patch, compile-test it and send it out
than it takes to complain about the breakage by mail. I also find it
slightly more helpful than just telling somebody that their patch broke
something.

Perhaps this is a bad example because it's really a trivial issue, but
if it were anything slightly more complex, then sending a patch for it
may save some maintainer the additional work. I don't immediately see
what's wrong with that. Perhaps you'd care to elaborate.

> and Stefano posted patch that declares struct bio_vec; instead.
> 
> Either way is ok with me, I'd generally prefer to avoid the ifdefs though.

I agree, that's much nicer than the #ifdef.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131111/1700a2d2/attachment.sig>
