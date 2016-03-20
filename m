From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 20 Mar 2016 19:41:46 +0100
Subject: [linux-sunxi] Re: [PATCH 0/8] ARM: dts: sun8i: Orangepi Plus dts
 improvements
In-Reply-To: <CAGb2v65THg3fcdTJvFBCxxbSU_vOWmB9tP4f2QUbPyUU9D=zig@mail.gmail.com>
References: <1458489636-2825-1-git-send-email-hdegoede@redhat.com>
 <CAGb2v65THg3fcdTJvFBCxxbSU_vOWmB9tP4f2QUbPyUU9D=zig@mail.gmail.com>
Message-ID: <56EEEEEA.8050401@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20-03-16 17:05, Chen-Yu Tsai wrote:
> Hi,
>
> On Mon, Mar 21, 2016 at 12:00 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi Maxime and Chen-Yu,
>>
>> Here is a series with various improvements for the Orangepi Plus dts.
>> Some (most) of these patches have been submitted before, esp. the USB
>> ones have multiple revisions before. But I lost count of their version,
>> so I'm posting this as a "new" set.
>>
>> About the USB patches, these rely on the patches to add support for
>> multiple-reset controllers to ohci-platform / ehci-platform. These
>> patches are all acked up and will go upstream as soon as v4.6-rc1 is
>> released (they depend on changes which will go into v4.6-rc1).
>
> Does this mean you or I can send the Orange Pi PC DTS patch?

Yes, I was planning on submitting a v2 of it shortly, with support
for IR and the LEDs / buttons added.

Regards,

Hans

p.s.

I just noticed a problem with the pinctrl node in
"Add leds and switches on Orangepi Plus boards"
patch, causing the following to show up in dmesg:

[    1.569702] sun8i-h3-r-pinctrl 1f02c00.pinctrl: unknown pin PL03
[    1.575741] sun8i-h3-r-pinctrl 1f02c00.pinctrl: unknown pin PL04

I'll submit a v7 soon, this replaces the one from this set, and should
be applied in the same order as the v6
