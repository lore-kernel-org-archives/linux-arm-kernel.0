From: andrea.adami@gmail.com (Andrea Adami)
Date: Fri, 4 Nov 2011 15:22:32 +0100
Subject: [RFC 0/5] restart cleanups
In-Reply-To: <20111104140155.GZ12913@n2100.arm.linux.org.uk>
References: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
	<20111101170225.GS19187@n2100.arm.linux.org.uk>
	<1320241747.20107.41.camel@ted>
	<20111102144934.GJ19187@n2100.arm.linux.org.uk>
	<CAAQYJAvAfFCwr1KH1CD7fKbD_keZK9iGAD20m110Qd_sX=icoA@mail.gmail.com>
	<20111104140155.GZ12913@n2100.arm.linux.org.uk>
Message-ID: <CAAQYJAsP35Y_a28awBgkVwP0Us8FVX28TxEp-Z7vovx66Zis2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 4, 2011 at 3:01 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Nov 04, 2011 at 02:58:02PM +0100, Andrea Adami wrote:
>> On Wed, Nov 2, 2011 at 3:49 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> >
>> > On Wed, Nov 02, 2011 at 01:49:07PM +0000, Richard Purdie wrote:
>> > > >From what I remember that hardware either always reboots or always
>> > > halts. I think the option was therefore left hardcoded to make it clear
>> > > it wasn't expected to work. Later Zaurii models could do either but
>> > > required some manual poking of registers to make it happen iirc.
>> > >
>> > > Regardless, you can probably clean this up as you suggest now.
>> >
>> > Thanks, I've now committed a change which removes the indirection
>> > entirely from poodle.
>> >
>> Hi, sorry for the late reply
>>
>> I'm playing with poodle and I can confirm that poweroff does indeed
>> not work with 2.6.3x kernels.
>> See this thread:
>> http://lists.linuxtogo.org/pipermail/zaurus-devel/2011-May/000501.html
>
> Okay, at least we know that restart works with that.
Yes, indeed

>
> I'm not offering to try and change the poweroff behaviour for the better,
> as I know absolutely nothing about the Zaurus platforms.
>
I see, np. I'm just puzzled because after a cold reset (pulling
battery out) poodle is acting as if powered off and does not restart
itself.
Apparently we cannot reach this state again after boot.

FYI the modern zaurus (corgi and spitz) do
suspend/resume/poweroff/restart flawlessy so it's only this machine
failing poweroff (and maybe collie, no idea).

Regards

Andrea
