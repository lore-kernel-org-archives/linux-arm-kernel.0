From: omar.ramirez@copitl.com (Omar Ramirez Luna)
Date: Thu, 6 Dec 2012 16:54:04 -0600
Subject: linux-next: manual merge of the arm-soc tree with the iommu tree
In-Reply-To: <CAK=WgbYDKN1deDTw3KvymvhoE1h_apX2E8zK=cDbu68+Gwcayw@mail.gmail.com>
References: <20121204154203.f0e7e87d1ae99e5c528434f8@canb.auug.org.au>
 <20121204110655.GE18368@8bytes.org>
 <CAK=WgbYDKN1deDTw3KvymvhoE1h_apX2E8zK=cDbu68+Gwcayw@mail.gmail.com>
Message-ID: <CAJ6Av5OBhpsSRiZNOa1a65yMT04Evaja6j8qPBiSuVM1DPdB1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

On Tue, Dec 4, 2012 at 5:10 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Tue, Dec 4, 2012 at 1:06 PM, Joerg Roedel <joro@8bytes.org> wrote:
>> On Tue, Dec 04, 2012 at 03:42:03PM +1100, Stephen Rothwell wrote:
>>> Today's linux-next merge of the arm-soc tree got a conflict in
>>> arch/arm/mach-omap2/clock44xx_data.c between commit 298ea44f211d ("ARM:
>>> OMAP4: hwmod data: ipu and dsp to use parent clocks instead of leaf
>>> clocks") from the iommu tree and commit 13a5b6228679 ("ARM: OMAP44xx:
>>> clock: drop obsolete clock data") from the arm-soc tree.
>>>
>>> I just deleted the file as the latter did and can carry the fix as
>>> necessary (no action is required).
>>
>> Ohad, Omar, any comment on this?
>
> I'd prefer Omar or Paul to have a look here. Looping in Tony as well.

I have checked next-20121206, it's OK to delete that file as the patch
from Paul is doing that for common clock framework migration; now the
only missing hunk from my original patch should apply to
arch/arm/mach-omap2/cclock44xx_data.c which is the file that now has
ipu_fck and dsp_fck (unused) clocks, I can send a patch to remove them
through linux-omap tree.

Cheers,

Omar
