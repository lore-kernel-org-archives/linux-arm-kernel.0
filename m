From: tobias.waldvogel@gmail.com (Tobias Waldvogel)
Date: Fri, 4 Jan 2013 21:36:13 +0100
Subject: [PATCH, RFC 2/3] ARM: gemini: remove platform support
Message-ID: <CAAAtp753RV1zaoPSxuoMuqron8i4cuptb4DC33cUy9nkzSgzXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>The gemini platform has not seen any updates from its
>maintainer since 2010, and has no defconfig file, which
>has lead to bitrot in a number of places:
>
>* System restart has been broken for a long time despite
>  repeated attempts from Russell to get the obvious
>  fix at least acknowledged by someone who can test it.
>* The platform still uses mach/gpio.h, which has been
>  deprecated for some time, and since Kconfig does not
>  select NEED_MACH_GPIO_H, it actually failed to build
>  because of this.
>* A change to asm/io.h introduced a number of compiler
>  warnings for gemini specific code that confuses
>  physical and virtual addresses.
>
>This removes gemini support entirely under the assumption
>that nobody uses it on mainline kernels. Of course, if
>there are still active users out there, they should let
>us know so we can put support back in and get it better
>tested.

I am using the Gemini platform for an OpenWRT port to the
NAS IB4220 B and I am maintaing patches for the complete
support, including network, disk and and USB.

A few days ago I ported everything already to 3.7.1 (pretty
much the same changes like I saw in RFC 1/3)

I am willing to become maintainer for this platform and
would apreciate to keep it in the mainline. There is also
no problem with the tests, as I have several devices and
more than 100 users using this kernel.

Thanks
Tobias
