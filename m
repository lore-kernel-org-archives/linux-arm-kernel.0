From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 19 Nov 2018 17:32:02 +0000
Subject: [PATCH v11 00/24] kasan: add software tag-based mode for arm64
In-Reply-To: <CAAeHK+xr04YNUY21osduxrVzxNEpiXZamSsFCGquvBD6JV6Lbw@mail.gmail.com>
References: <cover.1542648335.git.andreyknvl@google.com>
 <CAAeHK+xr04YNUY21osduxrVzxNEpiXZamSsFCGquvBD6JV6Lbw@mail.gmail.com>
Message-ID: <20181119173202.7pcxp5osupdw4t5t@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 06:28:57PM +0100, Andrey Konovalov wrote:
> On Mon, Nov 19, 2018 at 6:26 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> > Changes in v11:
> > - Rebased onto 9ff01193 (4.20-rc3).
> > - Moved KASAN_SHADOW_SCALE_SHIFT definition to arch/arm64/Makefile.
> > - Added and used CC_HAS_KASAN_GENERIC and CC_HAS_KASAN_SW_TAGS configs to
> >   detect compiler support.
> > - New patch: "kasan: rename kasan_zero_page to kasan_early_shadow_page".
> > - New patch: "arm64: move untagged_addr macro from uaccess.h to memory.h".
> > - Renamed KASAN_SET_TAG/... macros in arch/arm64/include/asm/memory.h to
> >   __tag_set/... and reused them later in KASAN core code instead of
> >   redefining.
> > - Removed tag reset from the __kimg_to_phys() macro.
> > - Fixed tagged pointer handling in arm64 fault handling logic.
> 
> Hi Mark and Catalin,

Hi Andrey,

> I've addressed your comments, please take a look.

Catalin and I have just returned from Linux Plumbers and are ctaching up
with things. I do intend to look at this, but it may take me a short
while before I can.

Thanks,
Mark.
