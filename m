From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Feb 2011 13:47:43 +0000
Subject: [PATCH V5 00/63] Updating SPEAr Support
In-Reply-To: <cover.1295499392.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
Message-ID: <20110219134743.GE29493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I don't understand why people think that it's a good idea to post a
patch series which adds new support and then has a whole series of
patches which modify then modifies both new and old stuff.

It makes it a lot harder to apply, a lot harder to review, and all
round is a bad idea.

The problem is that mixing it up in the way you've done means that
it's impossible to apply the cleanup patches before the new support.

Another issue worth pointing out is that submission of patch series
by email has to be done _carefully_ - which basically means slowly.
The email system on this planet will randomly re-order messages -
there is no guarantee that the order in which you send them is the
order in which they're received at the remote end.  If you want them
to arrive in a certain order, you're out of luck.

You can help by not dumping 63 patches into the mail system within a
few seconds or so, but leaving a greater period of time between each.
The longer that period, the more likely they are to arrive in order -
but it's something that will never be guaranteed.

As it is, I'm going to have to spend something like a few _hours_
over sorting out how to merge these Spear patches because they're all
out of order and they're all interdependent.

That's another argument for not waiting until you have a huge patch
set before sending stuff out - keep patch sets small and targetted to
specific areas.  For instance, with the Versatile updates which form a
total of 21 individual patches, I split them up into one set of 10
patches which changed the way CLCD stuff was handled, and another
separate set of 11 patches of platform specific stuff.

So, why aren't all the padmux changes together?  Why aren't the clk
API patches together?

And another thing: separate out the 'fixes' from the new developments.
Things like the addition of UL to VMALLOC_END counts as a warning fix.
Using readl_relaxed/writel_relaxed also counts as a fix as things in
the decompressor break.  As these are technically bug fixes, they go
upstream faster than new work.

Bug fixes should _always_ be at the very start of any patch series,
then cleanups, then new stuff.

In summary, I hate large patch sets.  I tend to ignore large patch
sets.  I have very little motivation to review large patch sets.  I
have very little motivation to apply large patch sets.  Don't create
them in the first place.  Spend time sorting the patches into smaller
sets and things all round go much easier.

I'll work through what you've already submitted, but it will be a
slow and erratic job.
