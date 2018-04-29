From: jon@solid-run.com (Jon Nettleton)
Date: Sun, 29 Apr 2018 16:09:31 +0200
Subject: [PATCH] ARM: dts: imx6qdl-cubox-i: Move card-detect GPIO to 1.5
 SOM devices only
In-Reply-To: <d167cc6987fdb7f04493c634873d430dcd216887.camel@paulk.fr>
References: <20180422142151.17910-1-contact@paulk.fr>
 <20180422143911.GB16141@n2100.armlinux.org.uk>
 <8012696a7bf0132dd2361a896bf0abfbe8a3084e.camel@paulk.fr>
 <d167cc6987fdb7f04493c634873d430dcd216887.camel@paulk.fr>
Message-ID: <CABdtJHun8DWbr-bUgwQEK61UXMLh5pPkwvUTF+KxhHmJaXEr-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 29, 2018 at 3:47 PM, Paul Kocialkowski <contact@paulk.fr> wrote:
> Hi,
>
> Le dimanche 22 avril 2018 ? 19:22 +0200, Paul Kocialkowski a ?crit :
>> Are all CuBox-i units that have ever been sold supposed to have a
>> connector with a CD line? I find it hard to believe that it's broken
>> specifically on mine.
>
> Do you have a clue whether there should, in fact, be a CD line on all
> CuBox-i models out there? Although you seemed to imply that my device
> might be broken, I am still confused about whether this issue concerns
> my device only or a specific revision of the CuBox-i.
>
>> If that's really needed, I could open up the device, check whether the
>> R8 pull is in place and check the voltage there.
>
> In case there is a doubt, I will proceed with opening the device so we
> can have a clear idea, but I'd rather avoid it as much as possible.
>
> Cheers,
>
> --
> Paul Kocialkowski,
>
> developer of free digital technology and hardware support.
>
> Website: https://www.paulk.fr/
> Coding blog: https://code.paulk.fr/
> Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

Paul,

You can see on our schematics that the hinged sdhc card slot is an
assembly option and not the default.
https://wiki.solid-run.com/lib/exe/fetch.php?media=imx6:cubox-i:schematics-rev-1.1:cubox-i-lower.pdf

You have either an initial early developer unit (pre-production) that
was assembled like this for testing, or a unit that someone
specifically ordered assembled this way.  You can see from the
schematic that this option does not have a CD-pin because it is meant
to be a more permanent storage option.

That being said, this is not a default option and therefore should not
be merged into the mainline device-tree.  Our soms and carriers are
designed to be very flexible regarding the assembly options and we try
to mainline device-tree files that represent the most common assembly
options.  Once there is a common accepted mainlining for device-tree
fragments for overlays, that would be the proper place to make this
change.  Although in this case you would also need a custom u-boot so
it is probably best to just handle the change there.  If you would
like touch base with me off list and I can point you at the required
u-boot changes.

Thanks,
Jon
