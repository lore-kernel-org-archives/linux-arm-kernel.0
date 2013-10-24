From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 24 Oct 2013 11:32:38 -0600
Subject: [Ksummit-2013-discuss] [RFC] of: Allow for experimental device
 tree bindings
In-Reply-To: <20131024080418.GE9403@ulmo.nvidia.com>
References: <1382540779-6334-1-git-send-email-treding@nvidia.com>
 <5267FA58.9050002@wwwdotorg.org> <20131023172001.GA3379@katana>
 <20131023185909.GC7863@ulmo.nvidia.com>
 <20131023193450.GE32563@obsidianresearch.com>
 <20131023195849.GA8828@mithrandir>
 <20131023210849.GB2912@obsidianresearch.com>
 <20131024080418.GE9403@ulmo.nvidia.com>
Message-ID: <20131024173238.GA23910@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 10:04:19AM +0200, Thierry Reding wrote:

> > The rule for experimental bindings should be that incompatible changes
> > to the binding must bump the version number at the same time, clearly
> > signalling to everyone using that binding that they need to take some
> > action.
> 
> I disagree. I think that we should apply the same rule to DT bindings
> (at least experimental ones) that we apply to code within the Linux
> kernel. If you change an experimental binding in an incompatible way
> then it should be your responsibility to update all users of it so that
> they don't break.

Absolutely, but these things are going to get out of the kernel tree
and people are going to be using them in broad contexts (eg flashing
them into firmware) - especially if we imagine the stablization window
is multiple kernel releases.

Clearly designating which revision is supported lets people know what
is going on, very explicitly.

Also, it lets people that might have the need to support multiple
versions in their out-of-tree DT by having repeated nodes.

I just think it is good practice to get people into the habit that the
compatible string indicates a single exact schema, and if you change
the schema you have to change the compatible string.

Always.

Jason
