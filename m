From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Feb 2012 18:47:42 +0100
Subject: [PATCH] pinctrl: make the pinmux-pins more helpful
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17BDDF2083@HQMAIL01.nvidia.com>
References: <1330062969-25016-1-git-send-email-linus.walleij@stericsson.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17BD8BCC79@HQMAIL01.nvidia.com>
 <CACRpkdZ-a+kyknb-q+_=TLGcNshwkLAY4918bwD7e6LzL3sWbg@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF2083@HQMAIL01.nvidia.com>
Message-ID: <CACRpkdZX+=9m-b+y9+tk0GQ+0TKmKasez+c=yY89ofkompf=bA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 6:27 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Linus Walleij wrote at Wednesday, February 29, 2012 2:39 AM:
>> On Fri, Feb 24, 2012 at 5:44 PM, Stephen Warren <swarren@nvidia.com> wrote:
>>
>> > If we do make a change like this, I'd prefer the format to be:
>> >
>> > UNCLAIMED
>> > "%s (HOG)", desc->owner
>> > desc->owner
>>
>> I don't see the point, the debugfs files are supposed to be
>> human-readable, a human is not interested in the fact that
>> the pinctrl device itself is owning the pin, what is interesting is
>> that it is hogged.
>
> Well, I'm a human and I care far more that the pin controller device is
> what owns the configuration rather than some artificial "hog" concept
> is present...

Yeah OK I'll try to add both then to please both instances of
human...

>> On U300 it makes a lot of sense even thogh it is essentially
>> group based. When sitting with the datasheet with the pin names
>> and use groups it's simple to see exactly how any one pin is muxed
>> for the moment and troubleshoot from there.
>
> If the HW muxes per group, then there's no concept of "which function is
> selected for a pin", since functions are selected for a group not for a
> pin.
>
> So, the datasheet will be written in terms of "group X supports functions
> A, B, C, D", not pins P, Q, R support functions "A, B, C, D". So,
> representing mux function in debugfs at the group level would make a lot
> more sense given that HW design.

I think we're talking past each other, it's that old thing with group
concepts again. I'd just say that for debugging
and understanding the muxing on U300 style hardware this
is very useful. It may be pointless in Tegra style HW.

Yours,
Linus Walleij
