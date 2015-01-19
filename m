From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Jan 2015 11:39:44 +0000
Subject: [PATCH v4] ARM: mvebu: remove two selects of ARM_ERRATA_753970
In-Reply-To: <1421659937.9655.16.camel@x220>
References: <1421659937.9655.16.camel@x220>
Message-ID: <20150119113944.GB26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 10:32:17AM +0100, Paul Bolle wrote:
> ARM_ERRATA_753970 was renamed to PL310_ERRATA_753970 in v3.2, through
> commit fa0ce4035d48 ("ARM: 7162/1: errata: tidy up Kconfig options for
> PL310 errata workarounds"). Still, two selects were added in v3.15 that
> used the previous name. So these selects have always been nops.
> 
> It is clear that the intention here was to select PL310_ERRATA_753970.
> But as, apparently, nothing broke for four releases we can assume
> PL310_ERRATA_753970 isn't actually needed. So let's not rename these two
> selects but just drop them instead.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> v4: Do no bother anymore to rename these selects. I've tried to do that
> a few times ever since v3.15-rc1 was released. Last time, v3, was in
> https://lkml.org/lkml/2014/9/12/231 . And since the people who
> intruduced this issue apparently aren't bothered by it, neither should
> I. So just do the safe and easy thing, which is removing these two
> selects, as they are nops now.

It's really for those who introduced these select statements to decide
what they want to do about them - but in principle, I'd agree with you.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
