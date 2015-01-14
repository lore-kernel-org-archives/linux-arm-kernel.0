From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 14 Jan 2015 11:03:42 +0100
Subject: [PATCH 0/4] ARM: shmobile: sh73a0/kzm9g: Complete multiplatform
 support
In-Reply-To: <20150114040822.GA14661@verge.net.au>
References: <1420809866-4330-1-git-send-email-geert+renesas@glider.be>
 <20150113020818.GB21265@verge.net.au>
 <CAMuHMdVbuM3oR1KQDzAodp_Y-aWFncPRn48-F9HmrVkGDS36RQ@mail.gmail.com>
 <20150114040822.GA14661@verge.net.au>
Message-ID: <CAMuHMdVBh+TntyXCDT0y=Bnntrh4Pu66vxPJ00o=Zi8+WwCvVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, Jan 14, 2015 at 5:08 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Jan 13, 2015 at 11:08:20AM +0100, Geert Uytterhoeven wrote:
>> On Tue, Jan 13, 2015 at 3:08 AM, Simon Horman <horms@verge.net.au> wrote:
>> > On Fri, Jan 09, 2015 at 02:24:26PM +0100, Geert Uytterhoeven wrote:
>> >> This patch series completes the migration from kzm9g-reference (legacy
>> >> DT based) to kzm9g-multiplatform (ARM multiplatform DT based with
>> >> common clock framework).
>> >>
>> >>   - The first two patches fix Ethernet on kzm9g, by adding a Bus State
>> >>     Controller node, as introduced in "[PATCH v3 0/4] drivers: bus:
>> >>     Add Simple Power-Managed Bus", and moving the Ethernet node to it,
>> >>   - The third path enables kzm9g support in shmobile_defconfig,
>> >>   - The fourth patch removes all kzm9g-reference support, now the
>> >>     sh73a0 generic multiplatform case has the same feature set
>> >>     (better, it provides 16 MiB more RAM!).
>> >>
>> >> Thanks for applying!
>> >
>> > It seems to me that at the first two patches require the patchset
>> > referenced above in order to work. For that reason I am holding off
>>
>> Yes it does.
>>
>> > on applying this series. I am quite happy to negotiate merging
>> > some or all of this series earlier than later :)
>>
>> Hence please merge both the dependency and this series.
>>
>>   1. Both sh73a0/kzm9g-multiplatform and r8a73a4/ape6evm-multiplatform
>>       depend on "[PATCH v3 0/4] drivers: bus: Add Simple Power-Managed Bus",
>
> For some reason I assumed this would go through a different subsystem tree.
> I'm fine with taking it through my tree, if you think that is best.

There's no maintainer for drivers/bus/, and as kzm9g-multiplatform depends on
it, your tree looks fine to me.

> I am a bit worried about handling conflicts that may arise, especially from
> the first two patches in that series which re-arrange things
> alphabetically. But I see that the files in question are not updated very
> often, so I suppose we should be safe enough.

Indeed.

> For now I have tentatively queued up both this patchset and the
> dependency listed immediately above. Please take a look
> at the sh73a0-multiplatform-for-v3.20 and drivers-for-v3.20 branches
> and the renesas-next-20150114-v3.19-rc1 tag to see if I missed something.

Thanks, looks fine!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
