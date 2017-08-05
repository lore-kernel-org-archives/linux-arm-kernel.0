From: lukas@wunner.de (Lukas Wunner)
Date: Sat, 5 Aug 2017 08:57:54 +0200
Subject: [PATCH 2/3] Split VGA default device handler out of VGA arbiter
In-Reply-To: <20170804102033.27731-3-dja@axtens.net>
References: <20170804102033.27731-1-dja@axtens.net>
 <20170804102033.27731-3-dja@axtens.net>
Message-ID: <20170805065754.GA8509@wunner.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 04, 2017 at 08:20:32PM +1000, Daniel Axtens wrote:
> A system without PCI legacy resources (e.g. ARM64, powerpc) may
> find that no default/boot VGA device has been marked, because the
> VGA arbiter checks for legacy resource decoding before marking a
> card as default.

Would it be feasible to just sprinkle some "if (IS_ENABLED(CONFIG_X86))"
over the portions of vgaarb.c that deal with legacy resources?

I'm missing some context as to the negative consequences you're
experiencing on other arches (the cover letter merely refers to
"quirks in ppc and concerns in arm land" and is missing links to
archived versions of v1 and v2), but clearly legacy resources are
x86-specific so any code dealing with them seems superfluous on
other arches and should be marked as such.

Please cc dri-devel when proposing changes to vgaarb.c (see
MAINTAINERS).

Thanks,

Lukas
