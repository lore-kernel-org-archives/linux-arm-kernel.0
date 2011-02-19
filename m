From: viresh.linux@gmail.com (viresh kumar)
Date: Sat, 19 Feb 2011 23:18:01 +0530
Subject: [PATCH V5 00/63] Updating SPEAr Support
In-Reply-To: <20110219134743.GE29493@n2100.arm.linux.org.uk>
References: <cover.1295499392.git.viresh.kumar@st.com>
	<20110219134743.GE29493@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimH334RWer8ybHraaoEivbzPWVhaH3y6TmfXaa0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/19/11, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> I don't understand why people think that it's a good idea to post a
> patch series which adds new support and then has a whole series of
> patches which modify then modifies both new and old stuff.
>
> It makes it a lot harder to apply, a lot harder to review, and all
> round is a bad idea.
>
> The problem is that mixing it up in the way you've done means that
> it's impossible to apply the cleanup patches before the new support.
>

Yes, understood it well now. This will not happen again.

> Another issue worth pointing out is that submission of patch series
> by email has to be done _carefully_ - which basically means slowly.
> The email system on this planet will randomly re-order messages -
> there is no guarantee that the order in which you send them is the
> order in which they're received at the remote end.  If you want them
> to arrive in a certain order, you're out of luck.
>
> You can help by not dumping 63 patches into the mail system within a
> few seconds or so, but leaving a greater period of time between each.
> The longer that period, the more likely they are to arrive in order -
> but it's something that will never be guaranteed.
>

As that is never guaranteed, can we have some other way to work out this issue?
I hope the issue is regarding the correct ordering of patches, as you
don't see the
numbering of these in the patch tracker? Is there anything more to it?

If this is the case, then may be we can send cover-letter along with
patch series
mentioning correct order of patches in it, and keeping you in cc of
cover-letter alone, so that
cover-letter is not lost by tracker, as it only takes patches.

> That's another argument for not waiting until you have a huge patch
> set before sending stuff out - keep patch sets small and targetted to
> specific areas.  For instance, with the Versatile updates which form a
> total of 21 individual patches, I split them up into one set of 10
> patches which changed the way CLCD stuff was handled, and another
> separate set of 11 patches of platform specific stuff.
>

Ok.

> So, why aren't all the padmux changes together?  Why aren't the clk
> API patches together?
>

We didn't thought you will be required to do rework on this. And
thought you will apply
this patch series as it is. But now as we see, you need to put extra
efforts due to our
mistakes, we will not repeat them.

> And another thing: separate out the 'fixes' from the new developments.
> Things like the addition of UL to VMALLOC_END counts as a warning fix.
> Using readl_relaxed/writel_relaxed also counts as a fix as things in
> the decompressor break.  As these are technically bug fixes, they go
> upstream faster than new work.
>
> Bug fixes should _always_ be at the very start of any patch series,
> then cleanups, then new stuff.
>

Ok.

> In summary, I hate large patch sets.  I tend to ignore large patch
> sets.  I have very little motivation to review large patch sets.  I
> have very little motivation to apply large patch sets.  Don't create
> them in the first place.  Spend time sorting the patches into smaller
> sets and things all round go much easier.
>
> I'll work through what you've already submitted, but it will be a
> slow and erratic job.
>

Sorry for that again!! And thanks for your effort and help.

--
viresh
