From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 23 Jan 2015 11:00:05 +0100
Subject: [PATCH 0/9] ARM: shmobile: r8a73a4/ape6evm multiplatform
In-Reply-To: <20150123042304.GE17548@verge.net.au>
References: <1421758306-24838-1-git-send-email-geert+renesas@glider.be>
 <20150121015927.GB30598@verge.net.au>
 <20150122033907.GO31170@verge.net.au>
 <20150123042304.GE17548@verge.net.au>
Message-ID: <CAMuHMdXR0fWRgPBgUe3=3UZ4jrDQe2Ot9L_OZHgQ1OCBnWdmog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Jan 23, 2015 at 5:23 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Jan 22, 2015 at 12:39:07PM +0900, Simon Horman wrote:
>> On Wed, Jan 21, 2015 at 10:59:27AM +0900, Simon Horman wrote:
>> > On Tue, Jan 20, 2015 at 01:51:37PM +0100, Geert Uytterhoeven wrote:
>> > > This patch series transitions the r8a73a4/ape6evm platform to support
>> > > multiplatform only:
>> > >   - Add CCF information to DT,
>> > >   - Disable legacy clock if CCF is used,
>> > >   - Add Bus State Controller node, and move the Ethernet node to it,
>> > >   - Remove ape6evm-reference,
>> > >   - Remove ape6evm-legacy and legacy support code.
>> > >
>> > > This series is based on renesas-drivers-2015-01-19-v3.19-rc5.
>> > > It depends on renesas-devel-20150119-v3.19-rc5 (code-wise) and
>> > > clk-shmobile-for-3.20 (functionality-wise), for which I've sent a pull
>> > > request to Mike Turquette yesterday.
>> > >
>> > > All of this was untested by me due to lack of hardware.
>> > > As Mike had previously acked the r8a73a4 CCF implementation, it's safe
>> > > to apply after testing.
>> >
>> > Hi Geert, Hi Ulrich,
>> >
>> > thanks for all your good work in getting this together.
>> > I have tested this and queued it up for v3.21.
>> >
>> > I plan to push it to my devel branch later today.
>> > I plan to push it to my next branch and thus linux-next once
>> > clk-shmobile-for-3.20 appears in a v3.20-rc.
>>
>> For the record: Olof has asked for review comments for the BSC driver and
>> binding patches. Accordingly I have dropped them, and these patches which
>> depend on them, from next.
>
> I have now had a chance to re-examine these patches and it seems to me that
> the first four patches of the series not depend on the BSC driver (or
> anything else).  With that in mind I have queued them up in a new
> r8a73a4-ccf-for-v3.21 branch which is present in
> renesas-devel-20150123-v3.19-rc5.
>
> Please take a moment to see if what I have done makes sense to you.  In
> particular it would be nicer if these patches could go into 'regular'
> branches such as dt-for-v3.21 and soc-for-v3.21. However it seems to me
> that the SoC patch "ARM: shmobile: ape6evm: Disable legacy clock
> initialization" depends on the following two DT patche " "ARM: shmobile:
> r8a73a4: Common clock framework DT description".
>
> For reference this covers the following patches:
>
> Enqueued (again):
>
> Ulrich Hecht (6):
>   ARM: shmobile: r8a73a4: Add CPG register bits header
>   ARM: shmobile: r8a73a4: Common clock framework DT description
>   ARM: shmobile: ape6evm: Disable legacy clock initialization
>   ARM: shmobile: r8a73a4: Add MSTP clock assignments to DT

OK, Thanks!

> Left Unqueued:
>
> Geert Uytterhoeven (2):
>   ARM: shmobile: r8a73a4 dtsi: Add Bus State Controller node
>   ARM: shmobile: ape6evm dts: Move Ethernet node to BSC
>
> Laurent Pinchart (1):
>   ARM: shmobile: r8a73a4: Remove legacy code
>
> Ulrich Hecht (6):
>   ARM: shmobile: ape6evm-reference: Remove board C code and DT file
>   ARM: shmobile: r8a73a4: ape6evm: Remove legacy platform

That's correct. Due to the non-working Ethernet in ape6evm-multiplatform,
ape6evm-reference (and -legacy) cannot be removed.
The same is true for sh73a0/kzm9g.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
