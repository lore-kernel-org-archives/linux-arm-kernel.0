From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Nov 2017 19:18:00 +0000
Subject: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for
 ntp
In-Reply-To: <20171127185352.GN31757@n2100.armlinux.org.uk>
References: <20171013175433.GA22062@obsidianresearch.com>
 <20171123095456.lkc4nkuzsd2q26mm@piout.net>
 <CALAqxLUBWd-mv_3iiFrXLf0ka685t0an89jjduHpT-2jjv5O2Q@mail.gmail.com>
 <20171127175254.GL31757@n2100.armlinux.org.uk>
 <20171127184411.GA19577@piout.net>
 <20171127185352.GN31757@n2100.armlinux.org.uk>
Message-ID: <20171127191800.GO31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Linus

Background:

Basically, Jason and myself developed an approach to fix a problem in
the RTC layer - https://marc.info/?t=150590661600002&r=1&w=3

John Stultz saw that discussion had ceased, and decided to merge the
cross-subsystem patch for 4.15.  Then, last week, Alexandre spots it
in mainline and decides he doesn't like it on fairly weak technical
grounds - see second message in:

https://marc.info/?t=150791745000009&r=1&w=3

I believe the grounds that Alexandre objects on are fairly weak as I
detailed in my replies to his objection.

What I can't fathom is why it would take someone two months to come
up with weak arguments against an approach, and then when I complain
about that and the prospect of it being reverted on those grounds,
the reaction is to revert it.

IMHO, maintainers have a duty to respond within a reasonable timescale,
and if patches get merged inspite of them, they need to consider
whether they're really doing a good job in the first place, and whether
they have *really good* reasons to object.

If maintainers are going to sit back, and let people work on problems,
and then have patches reverted only after they hit mainline, people are
just going to stop working on trying to solve problems - because no one
will know whether their approach is acceptable or whether they're merely
wasting their time.  That would be /very/ bad for Linux.

On Mon, Nov 27, 2017 at 06:53:52PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 27, 2017 at 07:44:11PM +0100, Alexandre Belloni wrote:
> > On 27/11/2017 at 17:52:54 +0000, Russell King - ARM Linux wrote:
> > > I'm actually rather disappointed that Alexandre Belloni has only now
> > > brought up his dis-satisfaction with the approach after all the effort
> > > that Jason and myself have put in to it.  It's not like Alexandre was
> > > not copied on the patches and discussion.
> > > 
> > > If Alexandre could not be bothered to bring up his concerns while the
> > > discussion was on-going in September, and didn't bother raising them
> > > in October, I'd say that Alexandre's opinion at this point doesn't
> > > count for much - if it wasn't important to state at the time or for
> > > a couple of months after, why does it become important to state after
> > > the thing has been merged.
> > > 
> > > Maybe the idea here is basically to waste people's time letting them
> > > develop a patch for an approach, and then object at the last minute
> > > to that approach.  Hardly seems fair or even reasonable.
> > > 
> > 
> > How unfair that is! Really, you are not in a position to make that kind
> > of comment because you are not even replying to patches in your own
> > subsystem. But maybe my time doesn't count as much as yours.
> 
> You are, yet again, wrong.
> 
> I am in a position to make the comment because it was me who identified
> the problem, put in the hours to work on, develop and extensively test
> Jason's patch.  So, it's partly my time that you seem to be wasting,
> and that gives me every right to complain at this point.
> 
> You, on the other hand, were copied with every single email, and did
> nothing to discuss the issue except for the "easy" bits when I posted
> a relatively smaller patch - but you ignored the bigger issue.
> 
> Now that the patch was merged, you throw your toys out of the pram and
> start blaming everyone else for "silently" merging the patch and how it
> wasn't sent to the right email addresses.
> 
> And now that someone dare criticise your abilities, you decide to revert
> the change and restore Linux back to a crippled state.
> 
> Honestly, I don't _care_ if you revert it and if you want to cripple
> the kernel as a result in regards to this issue, I can carry the patch
> ad infinitum, no skin off my back.  You're only going to be hurting
> yourself and other people through your spite by doing that revert.
> 
> I suggest you take a good long hard look at what you're about to do and
> ask whether you are being reasonable, given that it's taken you over
> two months whole months to raise any _technical_ issues with the approach
> that Jason and myself came up with.
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
