From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 3 Jul 2018 18:39:56 +0100
Subject: [RFC/RFT PATCH 0/2] disable_hest quirk on HP m400 with bad UEFI
 firmwware
In-Reply-To: <1530638172.31922.25.camel@debian.org>
References: <20180628100656.10692-1-james.morse@arm.com>
 <CAKv+Gu9ZHAGzcfgHShM1qvZ3qf4gb1pD_XfoceJu9Qy+5_pEsg@mail.gmail.com>
 <1530607466.9841.124.camel@debian.org>
 <CAKv+Gu8VYZ1dCggPjakcvqOxfUCeCAABEADmF2Bm-q3=y3J4ng@mail.gmail.com>
 <1530632871.9841.139.camel@debian.org>
 <20180703171251.GC11614@red-moon>
 <1530638172.31922.25.camel@debian.org>
Message-ID: <20180703173943.GA11764@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2018 at 06:16:12PM +0100, Ian Campbell wrote:
> On Tue, 2018-07-03 at 18:12 +0100, Lorenzo Pieralisi wrote:
> > I do not think anybody is preventing that, it is just that we do not
> > see the reason for adding a DMI quirk to the mainline kernel to enable
> > a platform with broken firmware that cripples one of the main feature
> > it is supposed to implement, we can go on forever about this but that's
> > the gist.
> 
> The quirk turns off a broken feature on the platform where it is
> broken, not everywhere, there's no "crippling" of the feature.
> 
> Or are you suggesting that you have in mind a way to fix this which
> makes HEST work even on m400 and renders the quirk unnecessary?

HEST error reporting is broken on those platforms and it is one
of the main features we expect from FW in ACPI systems, that
glossing over the legacy nature of m400 platforms.

What I do not understand, and Ard pointed that out already, is why we
should add a DMI quirk to the mainline kernel (that he tried/is trying
very hard to prevent since ACPI for ARM64 was merged) to enable a legacy
platform with missing/broken (HEST) key FW functionality in a
distribution.

If we answer that question we can merge this series but I see no
compelling reason for the time being.

Thanks,
Lorenzo
