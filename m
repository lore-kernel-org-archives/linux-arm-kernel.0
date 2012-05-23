From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 May 2012 17:10:10 -0700
Subject: Bad ux500 merge fix leads to linux-next failure
In-Reply-To: <20120523000346.GB3610@windriver.com>
References: <20120523000346.GB3610@windriver.com>
Message-ID: <CAOesGMgSGZqMtcCGv0f8oyoPmDFiGbPm0=1KxkNsZVG0LZPO9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Yeah, there was some confusion earlier, and I noticed that when
staging the branches for Linus last night. I'll rebuild for-next
tonight and take care of it then, thanks for the reminder!


-Olof

On Tue, May 22, 2012 at 5:03 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> Hi Olof,
>
> This change:
>
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?id.o usb.o timer.o
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?id.o pins.o usb.o timer.o
>
> breaks the u8500_defconfig as follows:
>
> make[2]: *** No rule to make target `arch/arm/mach-ux500/pins.o', needed
> by `arch/arm/mach-ux500/built-in.o'. ?Stop.
> make[1]: *** [arch/arm/mach-ux500/] Error 2
> make: *** [sub-make] Error 2
>
> A bisect shows the following:
>
> cda6f4d8cae969e08e6662573b538db73191873b is the first bad commit
> commit cda6f4d8cae969e08e6662573b538db73191873b
> Author: Olof Johansson <olof@lixom.net>
> Date: ? Wed May 16 14:47:24 2012 -0700
>
> ? ?ARM: ux500: fix mismerge in for-next
>
> ? ?Signed-off-by: Olof Johansson <olof@lixom.net>
>
> :040000 040000 abc42227f7daa6a7ff6153e0908add25ffb38a54
> 45d2618822e6075aea188089191791091c2e5c38 M ? ? ?arch
> bisect run success
>
> The linux-next fail is here:
> ? ? ? ?http://kisskb.ellerman.id.au/kisskb/buildresult/6348609/
>
> Can you have a look please?
>
> Thanks,
> Paul.
