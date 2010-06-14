From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 13 Jun 2010 23:36:57 -0600
Subject: Request review of device tree documentation
In-Reply-To: <1276417792.1962.731.camel@pasglop>
References: <AANLkTilK4YkRMJqlcRDOAlGBzpdlZuSo9NF5NrRNocHT@mail.gmail.com>
	<33BD8E86-9397-432A-97BF-F154812C157B@digitaldans.com>
	<AANLkTilv6TtPZs0DAwd8JlSV_J3VvMsvtVVOOeQauOIn@mail.gmail.com>
	<4C13430B.5000907@firmworks.com> <1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop> <4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com> <1276408773.1962.574.camel@pasglop>
	<4C147EA5.3060500@firmworks.com> <1276417792.1962.731.camel@pasglop>
Message-ID: <AANLkTimc12G-YYTd4yQiviY-ijvJ9TzVEmxxaoF43xVR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 13, 2010 at 2:29 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sat, 2010-06-12 at 20:45 -1000, Mitch Bradley wrote:
>
>> Either fought or embraced. ?To the extent that it is possible to focus
>> solely on Linux and ARM, one could image doing a good HAL.
>
> That will come with a huge amount of comunity resistance sadly, but I
> can imagine distros liking it.
>
> In general, I much prefer having all the necessary native drivers in the
> kernel, and the device-tree to provide the right representation, and
> avoid trying to abstract "methods" via a HAL. It's the Linux philosophy
> as much as possible (even when defeated by ACPI).
>
> But if we're going to be forced by vendors into HALs, we can also make
> sure that whatever they come up with is half reasonable :-)

I think there is more to be concerned about regarding binary blobs
than HALs.  Many of the new SoCs require closed binaries to use all
the hardware right now (graphics cores in particular).

Board vendors seem to be taking the plunge and modifying the kernel
rather than trying to create a HAL for driving board specific
features.

>> (The reason I say ARM-only is ?because the
>> only other non-x86 architecture that has any "legs" left is PowerPC, and
>> PPC already has a coherent story.)
>
> Well, ppc story isn't that coherent as far as this goes :-) We don't
> keep OF alive, we have RTAS which is a pile of poo... etc...
>
> But yeah, we are fine without a HAL, so if we stick to OF as a
> bootloader and provider of the device-tree, we are fine.
>
>> > To some extent, in fact, doing that sort of stuff in OF or even in RTAS
>> > like we do on power is even worse than ACPI-like tables. At least with
>> > those tables, the interpreter is in the operating system, thus can run
>> > with interrupts on, scheduling on, etc...
>>
>> I have an FCode interpreter that can live inside the OS. ?It's
>> considerably simpler than the ACPI interpreter.
>
> That's the one thing I purposefully avoided mentioning :-)
>
> It's an interesting idea, I've though about it. If course, there's all
> sort of things to be careful about, such as who provides the f-code with
> virtual->physical mappings to devices, how they are represented, how
> much of the OF "forth" environment is accessible to such f-code, locking
> between f-code and kernel use of shared resources (especially true when
> dealing with things like i2c devices, plls, etc...).
>
> IE. THe base idea is simple. The implementation can be a huge can of
> worms.
>
> Cheers,
> Ben.
>
>> > ?With RTAS, or client interface
>> > calls, you'll end up with potentially huge slumps of CPU time "lost"
>> > into the bowels of the firmware.
>> >
>> >
>> > Cheers,
>> > Ben.
>> >
>> >
>> >
>
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
