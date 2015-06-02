From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Jun 2015 01:25:15 +0100
Subject: [RFC PATCH] ARM: add fixmap based earlycon support
In-Reply-To: <CAL_JsqK1fbd0p57iB996uZB6cFS4J5o0ieRs0pStseEb__FJ0w@mail.gmail.com>
References: <1430315508-7582-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150501161812.GN12732@n2100.arm.linux.org.uk>
 <CAKv+Gu-8ixKQtkpf=umHB76OZxo-dfGkOiQqDO7=evMebyDdUA@mail.gmail.com>
 <CAKv+Gu80bSqXbK5g9g9wBbG33mgqbrxJA68kNgAuK=LOoGDh5w@mail.gmail.com>
 <CAL_JsqKq6dS-i9mGY4_cn4P0MZRFv5CA_EcxwXxkLmgZJ7SFrg@mail.gmail.com>
 <20150601233106.GU2067@n2100.arm.linux.org.uk>
 <CAL_JsqK1fbd0p57iB996uZB6cFS4J5o0ieRs0pStseEb__FJ0w@mail.gmail.com>
Message-ID: <20150602002514.GV2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01, 2015 at 06:57:24PM -0500, Rob Herring wrote:
> On Mon, Jun 1, 2015 at 6:31 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >> > DT based earlycon is a *really* useful thing to have if you are
> >> > working on early kernel code.
> >> > With many of the DTs now having been extended with a
> >> > /chosen/stdout-path property, it really only takes a simple 'earlycon'
> >> > command line parameter (without any arguments) to get console output
> >> > as soon as the early DT scan is concluded. I suppose this is also a
> >> > useful thing for multi platform kernels?
> >>
> >> Certainly, that's the whole point. IMO, we should rip out most of
> >> DEBUG_LL when this is merged.
> >
> > If you think that, you're wrong.  DEBUG_LL exists to be able to debug
> > stuff well before the kernel gets anywhere near the C code.  It has
> > to stay.  It fills the gap where no C code can do any debugging.
> 
> Right, that is the part we should keep. However, we won't really need
> earlyprintk (which I recall you are no fan of) and we don't need all
> the kconfig of addresses which is getting quite unwieldy.

Both points are true, but we definitely want to keep the information
concerning where the uarts are.  I certainly don't want to go hunting
in old paper documentation for some of that information... maybe
moving it into Documentation/arm somewhere would make sense -
possibly in a set of per-vendor files or maybe a single file separated
by vendor or something like that to break it up from being one huge
conflict-ridden list.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
