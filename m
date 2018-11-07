From: andreyknvl@google.com (Andrey Konovalov)
Date: Wed, 7 Nov 2018 16:56:21 +0100
Subject: [PATCH v10 00/22] kasan: add software tag-based mode for arm64
In-Reply-To: <20181107153456.GE2623@brain-police>
References: <cover.1541525354.git.andreyknvl@google.com>
 <CAAeHK+yOsP7V0gPu7EpqCbJZqbGQMZbAp6q1+=0dNGC24reyWg@mail.gmail.com>
 <20181107145922.GD2623@brain-police>
 <CAAeHK+zNgv9WxRpf7N3gmsLYGL6oUALAnyerMzeYZUz1LhoUuA@mail.gmail.com>
 <20181107153456.GE2623@brain-police>
Message-ID: <CAAeHK+yRAVo5S1Fb__uzK=drpXRBuB8-KvL8yQL8sfUG-Tr1Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2018 at 4:34 PM, Will Deacon <will.deacon@arm.com> wrote:
>
> I would like the patches that touch code under arch/arm64/ to be reviewed by
> somebody from the arm64 community. Since the core parts have already been
> reviewed, I was suggesting that you could split them out so that they are
> not blocked by the architecture code. Is it not possible to preserve the
> existing KASAN behaviour for arm64 with the core parts merged? I figured it
> must be, since you're not touching any other architectures here and they
> assumedly continue to function correctly.

It's possible to split out the core mm part, but it doesn't make much
sense to merge it separately from the arm64 changes.

> However, if you'd rather keep everything together, please can we give it a
> couple of weeks so we can at least get the architecture bits reviewed? Most
> people are out at LPC next week (and I'm at another conference this week).

OK, sounds good!

Catalin, could you take a look at the arm64 specific changes?
