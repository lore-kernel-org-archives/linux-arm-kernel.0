From: dromede@gmail.com (=?UTF-8?B?TWFya28gS2F0acSH?=)
Date: Wed, 12 Dec 2012 18:22:34 +0100
Subject: [ARM] head.S change broke platform device registration?
In-Reply-To: <1355327745.6771.56.camel@ted>
References: <CAHod+GdVobkgOj6bsFhn6qqLhysQoEzcDtAS05u1kPnssSfObg@mail.gmail.com>
 <50B88A59.6070207@arm.com>
 <CAHod+GeZQx6-pUHPocbyMJCLawMUhrZuZf=mrgWax=L7eNJGhg@mail.gmail.com>
 <20121130143435.GP19440@n2100.arm.linux.org.uk>
 <CAHod+GdXfZb1OHapJBYpCD74svYyaGaiZpqHLPtjHbWGa-3eLA@mail.gmail.com>
 <20121204221851.GJ14363@n2100.arm.linux.org.uk>
 <CAHod+Gd6NJsuJVRos52e9+NcweqcSu=HArT_qoV0ygb_Xbfaiw@mail.gmail.com>
 <20121205235836.GR14363@n2100.arm.linux.org.uk>
 <CAHod+Gf2z-S6B_Z6o_QHbvoLY7L-oYmPVgBzGW3rvKyWAS5apA@mail.gmail.com>
 <20121211002500.GP14363@n2100.arm.linux.org.uk>
 <1355327745.6771.56.camel@ted>
Message-ID: <CAHod+Gc-GAC5MVEjnbxytFvpdPJtKC63xKBagQvSWnvPygDWAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Or maybe Richard can suggest a more secure probing solution along the
>> lines of the above given his experience with these platforms.
>
> I think the proposal above should work. I don't have a borzoi device to
> test with however and have always been reliant on others for testing of
> that device detection. The above link is more documentation than I've
> ever seen before on scoop, I didn't have that when I wrote the driver, I
> just had to guess from other code from the Sharp 2.4 kernels.
>
> Cheers,
>
> Richard

There might be another, simpler way of implementing autodetection. Spitz devices
have a small NOR PROM chip that holds the bootloader, diagnostic menu
and other things
on it. Recently i have been informed that this chip also holds model
ID information.
So if it's possible to read the PROM chip that early in the boot
process, autodetection
could easily be implemented by just reading this model information.
Here's some more info:

http://lists.linuxtogo.org/pipermail/openembedded-devel/2009-January/007597.html
