From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 1 Nov 2013 10:23:28 +0100
Subject: [PATCH] clk: Properly initialize reference count
In-Reply-To: <5272AAD7.9050305@wwwdotorg.org>
References: <1383220962-26836-1-git-send-email-treding@nvidia.com>
 <5272AAD7.9050305@wwwdotorg.org>
Message-ID: <20131101092327.GD27864@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 01:09:11PM -0600, Stephen Warren wrote:
> On 10/31/2013 06:02 AM, Thierry Reding wrote:
> > Commit a336ed7 (clk: Implement clk_unregister()) initializes the kref in
> > clk_set_parent(), which is obviously the wrong place. Further research
> > shows that the original patches initialized it correctly, so it probably
> > ended up in clk_set_parent() by mistake during manual application of the
> > patch.
> 
> Tested-by: Stephen Warren <swarren@nvidia.com>
> 
> BTW, it'd be nice to Cc fixes like this to linux-next at vger.kernel.org;

Yes, perhaps that would've been a good idea.

> I /might/ have avoided doing a bisect if I'd seen this patch first!

I get that bisect is a really nice tool. But I don't understand why
people seem to rely on it to track down *everything* nowadays. In this
particular case there was a fairly obvious warning that pretty clearly
pointed at something wrong with the reference counting and some simple
code inspection revealed the issue at hand. No need to rebuild and boot
the kernel dozens of times to find this out.

But perhaps other people have much faster machines and bisection is
actually faster...

> I see the benefit of that "linux-next plus today's accumulated
> bug-fixes" tree that I think you proposed:-)

Yeah, this is precisely the situation where this would be good to have.
Both of these issues together took about 45-60 minutes to track down and
fix. I suppose it took Olof and you a similar amount of time. Yet if the
fixes were already collected in some standard location it would free you
up to do something more productive instead of wasting your time on
duplicate work.

I'll ask Stephen (Rothwell) if he'd be willing to set up shared access
to linux-next so that I can push collected fixes. Alternatively I could
do that in a separate repository.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131101/97b366d5/attachment.sig>
