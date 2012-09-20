From: gclement00@gmail.com (Gregory CLEMENT)
Date: Thu, 20 Sep 2012 17:24:11 +0200
Subject: [PATCH] ARM: mxs: m28evk: Disable OCOTP OUI loading
In-Reply-To: <20120920151021.7307C203A17@gemini.denx.de>
References: <1348007837-23187-1-git-send-email-marex@denx.de>
 <201209201420.55526.marex@denx.de> <20120920125631.GC2609@pengutronix.de>
 <201209201510.24631.marex@denx.de> <505B1FC2.2090609@free-electrons.com>
 <20120920151021.7307C203A17@gemini.denx.de>
Message-ID: <CADx9zJCnQCnGgvO6ui7m1buAt2S+OPyQVgyEBwt-u2ARcqh94Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/9/20 Wolfgang Denk <wd@denx.de>:
> Dear Maxime,
>
> In message <505B1FC2.2090609@free-electrons.com> you wrote:
>>
>> > Fix it and send patch, so this problem doesn't spread.
>>
>> I'm sorry, but you still miss the point.
>
> I'm not so sure about this.
>
>> If someone wants to use another bootloader than U-boot (or a possible
>> patched barebox), or none other than the bootlets to boot directly the
>> Linux (with an appended device tree), you will still have no way to get
>> the NIC from the OCOTP, and I'm sorry, but it is just wrong.
>
> With device tree supoort enabled, the regular way to pass the MAC
> address to a network interface (that needs one) is through the device
> tree.
>
> There are several options how such information gets there.  Boot
> loaders with built-in DT support may fill in the MAC address
> information into the DT before passing it to the Linux kernel.
>
> If your boot method does not allow such dynamic adjustment, you ould
> provide a statically configured device tree, which already includes
> the MAC address.
>
>> The kernel shouldn't rely on a particular feature of a given bootloader.
>
> 100% agreed.  And it does not.  It always uses the respective
> information from the device tree.

I thought that device tree should provide information that we can't get
by the hardware itslef. Here, if the hardware can provide the MAC address,
why should we ignore it?

>
>
> So when you use bootlets, all you need to do is to insert the
> respective MAC address entry to your device tree definition.
>


> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
> Every program has at least one bug and can be shortened by  at  least
> one  instruction  --  from  which,  by induction, one can deduce that
> every program can be reduced to one instruction which doesn't work.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Gregory CLEMENT
