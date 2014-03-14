From: lho@apm.com (Loc Ho)
Date: Fri, 14 Mar 2014 14:38:57 -0700
Subject: [PATCH v17 3/4] ata: Add APM X-Gene SoC AHCI SATA host controller
 driver
In-Reply-To: <201403142206.36611.arnd@arndb.de>
References: <1394655573-32645-1-git-send-email-lho@apm.com>
 <201403142005.52991.arnd@arndb.de>
 <CAPw-ZT=1KWEowD_i=qoWwg372XdzC4p227rpNo7ov+NwOYFUDA@mail.gmail.com>
 <201403142206.36611.arnd@arndb.de>
Message-ID: <CAPw-ZTkk3n_6wh-bWnaMf0aL6mgZWxNH7Sf=J9ucv0uvH2trVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

>> >> > gets called. Can you clarify what this register access does?
>> >> > If it's just setting a index into a mux output, would it make
>> >> > sense to have an optional DT property containing an integer with
>> >> > the mux setting you want to set? That way you wouldn't even
>> >> > have to have two compatible strings but just do
>> >> >
>> >> >         ret = of_property_read_u32(node, "apm,ahci-mux", &mux);
>> >> >         if (!ret)
>> >> >                 xgene_ahci_mux_select(ctx, mux);
>> >> >
>> >>
>> >> Given that fact that I will break up the resource. Let's just use the
>> >> resource for the MUX to handle this. For the IP that doesn't existed,
>> >> I will just not list it.
>> >
>> > Ah, that sounds good. It also means that if the firmware has set up
>> > the mux already, you don't have to touch it again. That would probably
>> > be the preferred case.
>> >
>> > I'm undecided about the value that you write in there. That could either
>> > be passed through DT as I suggested above for extra flexibility, or you
>> > can keep it hardcoded if you are absolutely sure that there will never
>> > need to be a case where you have to set it to something other than '1',
>>
>> It is only a mux between two IP's. Writing 1 is fine. For ACPI, it can
>> be missing and handled by the firmware or can be handled just like the
>> DTS way.
>
> Why can't you have it handled by the firmware in the DTS case?
>
> I still think it's rather unlikely that we will actually see ACPI support
> on your platform, btw.
>
> I'm willing to look at the patches you need for it, but I'm not very
> optimistic, in particular because of the kind of hacks you need
> for random bits of hardware.
>

I am about to post another version. Can you look at the next version?
If you still think it needs to be moved to the FW (either U-Boot or
Tianocore UEFI boot loader), I will then move out of the Linux driver
code.

-Loc
