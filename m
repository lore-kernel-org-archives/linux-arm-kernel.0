From: sam@ravnborg.org (Sam Ravnborg)
Date: Sun, 5 Nov 2017 09:39:28 +0100
Subject: [PATCH 2/2] kbuild: handle dtb-y and CONFIG_OF_ALL_DTBS natively
 in Makefile.lib
In-Reply-To: <1509859853-27473-3-git-send-email-yamada.masahiro@socionext.com>
References: <1509859853-27473-1-git-send-email-yamada.masahiro@socionext.com>
 <1509859853-27473-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20171105083928.GA28930@ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro

Nice cleanup - looks good.

> --- a/arch/mips/boot/dts/brcm/Makefile
> +++ b/arch/mips/boot/dts/brcm/Makefile
> @@ -37,5 +37,3 @@ obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
>  
>  # Force kbuild to make empty built-in.o if necessary
>  obj-				+= dummy.o

I noticed a few of these dummy.o in the patched files.
Looks like another candidate for cleaning up - in a separate patch.

	Sam
