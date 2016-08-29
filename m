From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 29 Aug 2016 22:15:51 +0200
Subject: [RFC PATCH 0/3] ARm64: amlogic: Introduce common GX family dtsi
In-Reply-To: <20160829195030.GA10797@localhost>
References: <1472457371-1305-1-git-send-email-narmstrong@baylibre.com>
 <CAOQ7t2YGbASh7v25wgDspKNWgFOcRsikJs_WZptn+LkVXmaHig@mail.gmail.com>
 <2983d731-82fd-63fc-7541-8c1d6a929416@suse.de>
 <20160829195030.GA10797@localhost>
Message-ID: <ca513cb4-34d4-72f9-9e32-7908329243a6@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 29.08.2016 um 21:50 schrieb Carlo Caione:
> On 29/08/16 20:38, Andreas F?rber wrote:
>> Am 29.08.2016 um 10:01 schrieb Carlo Caione:
>>> On Mon, Aug 29, 2016 at 9:56 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>> Neil Armstrong (3):
>>>>   ARM64: dts: amlogic: Add Meson GX Family common dtsi
>>>>   ARM64: dts: amlogic: Switch Meson GXL dtsi to use common GX dtsi
>>>>   ARM64: dts: amlogic: Switch Meson GXBB dtsi to use common GX dtsi
>>
>> Adding an unused .dtsi duplicating GXBB makes me uneasy.
> 
> S905x (GXL) is different from S905 (GXBB), it's unused now but in the
> future we can expect something different in the two DTSI.

Guess I need to be --verbose. ;)

I meant: After patch 1/3 there is a gx-common.dtsi that duplicates
contents of gxbb.dtsi and is not yet #include'd anywhere, i.e., unused.

>> Any chance we can simplify this to at most two steps?
>> 1) Move code from gxbb to gx (1/3 + 3/3)
>> 2) Add gxl using gx ("Add basic support for Amlogic S905X" + 2/3)
> 
> fine by me.
> 
>> Alternatively:
>> 1) "Add basic support for Amlogic S905X"
>> 2) Factor out common bits (1/3 + 2/3 + 3/3)
> 
> how is this different from this patchset?

I'm suggesting we do "atomic" move operations, not copy and then remove.

The difference between my two suggestions is how many and which changes
we squash - I do appreciate that it's easy for review as is but what I
have in mind is that either we should get this refactoring applied asap
(#1 1)) and rebase all pending patches on it, or we may need to rebase
the refactoring onto any pending MMC, SDIO, etc. patches, which I feel
is safer to do in one big patch (#2 2)) than split over multiple ones.
It really depends on the merge order and roadmap you guys have in mind.

>> As for bike-shedding, is there a GX family as well or could we drop
>> -common? .dtsi is always something common - compare Exynos or i.MX.
>> Since there are meson8b and meson8 I was anticipating that after gxbb
>> would come gx, not gxl.
> 
> AFAIK we have:
> - GXBB
> - GXL
> - GXM
> - GXTVBB
> 
>> Do you know what the L in GXL is for? Should we consider renaming gxbb
>> to gxb, and then also insert -s905 as suggested by Kevin, for symmetry?
> 
> Yes, that make sense.

Hm, GXTVB would still be longer than GXL then, not much point then.
We could still do -gxbb-s905 though.

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
