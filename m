From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Sep 2012 23:52:18 -0700
Subject: [PATCH] ARM: add back in KS8695 based SnapGear board entries
In-Reply-To: <20120910084259.GQ13739@n2100.arm.linux.org.uk>
References: <1347247815-6751-1-git-send-email-gerg@snapgear.com>
 <20120910084259.GQ13739@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMhSvxGaKfM7uUm9v1CAHzYi_4XhJPaiYeBm7ZeuXnx=4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 10, 2012 at 1:42 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Sep 10, 2012 at 01:30:15PM +1000, gerg at snapgear.com wrote:
>> From: Greg Ungerer <gerg@uclinux.org>
>>
>> Board support code for the SnapGear boards based on the Micrel KS8695 SoC
>> will soon appear in mainline kernel. The board IDs had been removed from
>> the mach-types file, so add them back in.
>
> Nak.  You must add platform support for these numbers _along_ _side_
> adding them back to mach-types, otherwise my scripts will simply delete
> them again.  These entries have been aged out due to lack of merging of
> the platforms.

Greg has submitted the new platforms for arm-soc but building of them
will be broken until this update goes in.

I guess we have the option of picking up the platform patch but not
enabling it in the ks8695 defconfig until it's buildable (or enable it
and have build breakage, which isn't awesome). Or, if you're OK with
it (and give us an acked-by) we can include the mach-types patch in
the same branch where the platform support gets merged.

Russell, do you have a preference?


-Olof
