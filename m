From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Thu, 6 Oct 2016 23:00:51 +0100
Subject: [PATCH] Revert "debugfs: ->d_parent is never NULL or negative"
In-Reply-To: <f6ba2bf7-4f0b-e874-d642-6620d5df2212@codeaurora.org>
References: <1475789429-11414-1-git-send-email-okaya@codeaurora.org>
 <20161006213734.GM19539@ZenIV.linux.org.uk>
 <f6ba2bf7-4f0b-e874-d642-6620d5df2212@codeaurora.org>
Message-ID: <20161006220050.GN19539@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 06, 2016 at 05:41:34PM -0400, Sinan Kaya wrote:
> On 10/6/2016 5:37 PM, Al Viro wrote:
> > On Thu, Oct 06, 2016 at 05:30:29PM -0400, Sinan Kaya wrote:
> >> This reverts commit acc29fb8f792 ("debugfs: ->d_parent is never NULL or
> >> negative") as it breaks the debugfs_remove_recursive API as show in the
> >> callstack below.
> > 
> > NAK.  Fix your code, don't break global asserts.
> > 
> 
> I can fix the code if you tell me what the problem is:

Getting dentries with NULL ->d_parent should never, ever happen.  Find the
place where such a beast appears and you've got your problem.

The same goes for negative dentries with children.  Again, if your code
triggers such a situation, find where it does so and you've found a bug.
More than one, at that.
