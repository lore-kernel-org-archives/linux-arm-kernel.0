From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 06 Sep 2014 16:16:21 +0200
Subject: [PATCH] arm64: LLVMLinux: Provide __aeabi_* symbols which are
 needed for clang
In-Reply-To: <1409959394-14936-1-git-send-email-behanw@converseincode.com>
References: <1409959394-14936-1-git-send-email-behanw@converseincode.com>
Message-ID: <2954780.2t9bpyu7ov@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 September 2014 16:23:14 behanw at converseincode.com wrote:
> --- /dev/null
> +++ b/arch/arm64/lib/eabi.c
> @@ -0,0 +1,32 @@
> +/*
> + *  linux/lib/eabi.c

Please don't put the file names in the files themselves, it's redundant
and in this case actually wrong.

> + *  Copyright (C) 2012  Mark Charlebois
> + */
> +
> +/*
> + * EABI routines

Does EABI specify these function names? I would think that they are
just random libgcc (whatever that is called in clang) functions.

	Arnd
