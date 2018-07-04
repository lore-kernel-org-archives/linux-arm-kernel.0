From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 4 Jul 2018 12:59:00 +0900
Subject: [PATCHv5 1/4] kbuild: Add build salt to the kernel and modules
In-Reply-To: <20180703233430.14416-2-labbott@redhat.com>
References: <20180703233430.14416-1-labbott@redhat.com>
 <20180703233430.14416-2-labbott@redhat.com>
Message-ID: <CAK7LNAS7XBwDidNaLKC1wD+G30AyAvTHG5GN=UAiP5zz1EO8JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

Thanks for the update.


2018-07-04 8:34 GMT+09:00 Laura Abbott <labbott@redhat.com>:
>
> The build id generated from --build-id can be generated in several different
> ways, with the default being the sha1 on the output of the linked file. For
> distributions, it can be useful to make sure this ID is unique, even if the
> actual file contents don't change. The easiest way to do this is to insert
> a section with some data.
>
> Add an ELF note to both the kernel and module which contains some data based
> off of a config option.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v5: I used S-o-b here since the majority of the code was written
> already.


I think Suggested-by is good enough.
S-o-b is appended as a patch is passed from people to people.

Anyway, this looks good except one bike-shed.

> Please feel free to change the tag if you think it's not
> appropriate. I also tweaked this to take an ascii string instead of just
> a hex value since this makes things much easier on the distribution
> side.
> ---


> diff --git a/init/Kconfig b/init/Kconfig
> index 041f3a022122..8de789f40db9 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -107,6 +107,15 @@ config LOCALVERSION_AUTO
>
>           which is done within the script "scripts/setlocalversion".)
>
> +config BUILD_SALT
> +       string "Build ID Salt"
> +       default "Linux"


How about empty string ""
for default?




-- 
Best Regards
Masahiro Yamada
