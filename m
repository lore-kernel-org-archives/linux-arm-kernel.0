From: brian@walsh.ws (Brian Walsh)
Date: Thu, 24 Sep 2009 19:43:20 -0400
Subject: ixp4xx dmabounce
In-Reply-To: <19132.526.686296.154379@pilspetsen.it.uu.se>
References: <a104b22c0909171402x10c06d41oa5c78065a65836e1@mail.gmail.com>
	<19129.24807.954274.688709@pilspetsen.it.uu.se>
	<m33a6dk9li.fsf@intrepid.localdomain>
	<a104b22c0909240902g31da6983w26be4526cbdfc16c@mail.gmail.com>
	<19131.41836.967832.872623@pilspetsen.it.uu.se>
	<a104b22c0909241515oc2a878dw435c9e5fccb4f46b@mail.gmail.com>
	<19132.526.686296.154379@pilspetsen.it.uu.se>
Message-ID: <a104b22c0909241643u35db24e1t22645653ebc22248@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2009 at 7:34 PM, Mikael Pettersson <mikpe@it.uu.se> wrote:
> Brian Walsh wrote:
>> > =C2=A0> I tried Krzysztof's patch and it had no noticeable affect. =C2=A0=
>> I am still getting
>> > =C2=A0> about 6.3 Mbps IP data throughput when only using the ohci contro=
>> ller and
>> > =C2=A0> about 3.6 Mbps when the device is attached to the ehci controller=
>> . =C2=A0This
>> > =C2=A0> device works fine when running the same testing attached to an x8=
>> 6
>> > =C2=A0> configured machine and gets about 18 Mbps IP data throughput.
>> >
>> > If your application can operate in 64MB RAM, you may want to try
>> > a kernel that includes only my ixp4xx disable dmabounce patch,
>> > and boot it with mem=3D64M. (Look in the kernel boot log and verify
>> > that it only sees 64M of RAM.)
>> >
>> > If performance increases, then your performance loss is due to bounces.
>> >
>>
>> Mikael
>>
>> I used your patch to disable legacy bounce, disabled support for > 64MB RAM=
>> ,
>> and used the mem=3D64M kernel option. ?There was no change in the data
>> throughput.
>>
>> I am not sure where this leaves me.
>
> To me it implies that the performance issues are unrelated to
> your initial bouncing issues. Since you get better performance
> from OHCI I'd have to suspect a hardware or driver issue with
> your EHCI controller.
>

Yes that is what I was thinking.  I just tried 3 other PCI USB
controller cards with
different chipsets.  All had the same results.
