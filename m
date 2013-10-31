From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 31 Oct 2013 13:09:11 -0600
Subject: [PATCH] clk: Properly initialize reference count
In-Reply-To: <1383220962-26836-1-git-send-email-treding@nvidia.com>
References: <1383220962-26836-1-git-send-email-treding@nvidia.com>
Message-ID: <5272AAD7.9050305@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2013 06:02 AM, Thierry Reding wrote:
> Commit a336ed7 (clk: Implement clk_unregister()) initializes the kref in
> clk_set_parent(), which is obviously the wrong place. Further research
> shows that the original patches initialized it correctly, so it probably
> ended up in clk_set_parent() by mistake during manual application of the
> patch.

Tested-by: Stephen Warren <swarren@nvidia.com>

BTW, it'd be nice to Cc fixes like this to linux-next at vger.kernel.org; I
/might/ have avoided doing a bisect if I'd seen this patch first!

I see the benefit of that "linux-next plus today's accumulated
bug-fixes" tree that I think you proposed:-)
