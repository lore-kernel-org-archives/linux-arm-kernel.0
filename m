From: gorcunov@openvz.org (Cyrill Gorcunov)
Date: Wed, 20 Feb 2013 02:02:44 +0400
Subject: [patch 1/2] kcmp: Make it to depend on CONFIG_KCMP
In-Reply-To: <5123F32B.3000401@zytor.com>
References: <20130219064800.719149796@openvz.org>
 <20130219065210.030802820@openvz.org> <5123444D.6000806@suse.cz>
 <20130219093154.GF20312@moon> <5123BC2B.6000304@zytor.com>
 <20130219182838.GL20312@moon>
 <20130219134256.f4cedf44.akpm@linux-foundation.org>
 <5123F32B.3000401@zytor.com>
Message-ID: <20130219220244.GQ20312@moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 19, 2013 at 01:48:27PM -0800, H. Peter Anvin wrote:
> >
> >This permits people to select kcmp with CONFIG_CHECKPOINT_RESTORE=n.
> >Is there any point in doing that?
> >
> >What would be wrong with just doing
> >
> >	obj-$(CONFIG_CHECKPOINT_RESTORE) += kcmp.o
> >
> 
> The real question is if there are any potential use cases of kcmp()
> outside checkpoint/restore.  It is actually a very general facility.

As far as I remember Eric was pointing to such potential use at early
time when kcmp being only started developing (I'm trying to find this
email in archive, if only my memory doesn't betray me and it was about
something else ;) Nevertheless, one may write utility to output
statistics on shared "resource" used by a task (don't know if it's
that useful since we use kcmp for c/r sake, but still).
