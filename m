From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Jan 2012 13:00:35 +0100
Subject: Pinmux bindings proposal
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB445@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF17801D202F@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC6057885091DEA@039-SN2MPN1-013.039d.mgd.msft.net>
 <20120117082334.GA31295@S2101-09.ap.freescale.net>
 <7FE21149F4667147B645348EC6057885092D56@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17801D22F5@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC6057885095125@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF1780DAB445@HQMAIL01.nvidia.com>
Message-ID: <CACRpkdae58AYCYzwx8ysSDr_i0UHBfCujm2Fmnb+hx7825Lm4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 9:28 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Dong Aisheng wrote at Wednesday, January 18, 2012 4:06 AM:
>>
>> Each entry in the list is PIN rather than group.
>> So we cannot create each map for each entry in the list except we treat the PIN as
>> A group(this will cause a huge maps and predefined groups and functions).
>
> Linusw has NAKd the idea that we should not use these "virtual groups",
> i.e. he believes they're fine to use if you wish.

Interesting double inversion here: I NACK to NOT use groups
this way...

The groups are not "virtual" if they share some physical
property. Such as being used by the same device.

The subsystem has callbacks to list, name and get the
pins belonging to a group. What defines a group is up
to the driver, it better be something that makes sense
else the driver will likely become hard to maintain.

If and only if you enable the *OPTIONAL* pinmux part
of the pin control subsystem, there is something
called pinmuxes, these have pins associated with them,
and by design they have to present the pins associated
with them by naming one or more groups.

It is possible that the pinmux should be able to
contain single pins as well, Tony indicated something
like that to me. Currently you would have to use a
group with 1 pin in it to associate a single pin with
a pinmux, maybe this is not so elegant, it can be
fixed,

Yours,
Linus Walleij
