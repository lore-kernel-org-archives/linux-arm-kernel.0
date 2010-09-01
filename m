From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Sep 2010 08:39:13 +0100
Subject: [PATCH 0/3] Allow late mdesc detection, v4
In-Reply-To: <1282553423.737985.983362819420.0.gpush@pororo>
References: <1282553423.737985.983362819420.0.gpush@pororo>
Message-ID: <20100901073913.GF8142@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 23, 2010 at 04:50:23PM +0800, Jeremy Kerr wrote:
> Currently, we probe for a mdesc early in boot. At this early stage, the
> only thing we use the mdesc for is to determine the debug page mapping.
> 
> However, the debug addresses (phys and virt) need to be coded into the
> addruart macro anyway; the dynamic probing is only going to tell us what
> we already know.
> 
> These changes allow us to use the addruart macros to find the debug
> mapping addresses, rather than pulling them out of the mdesc. This means
> that the addresses are only kept in the one place, and that we don't
> need the mdesc nearly as early.

I fear that to merge them into my tree now will invite merge conflicts
and/or code breakage when something gets merged without regard to these
changes.  As I said last time around, the point to merge these (as newly
updated patches) is once we freeze new platform support just before the
next merge window.

So I'm not merging them until the potential last week prior to the merge
window opening - please keep an eye on Linus' -rc announcements and
send updated patches (against my -devel tree - this is one case where
we're going to have to do it this way) to the patch system at when Linus
indicates that he's released the final -rc.

Thanks.
