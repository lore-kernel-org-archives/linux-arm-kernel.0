From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Jan 2016 10:08:44 +0100
Subject: [PATCH v6 11/21] arm64: ilp32: introduce binfmt_ilp32.c
In-Reply-To: <1452209679-19445-12-git-send-email-ynorov@caviumnetworks.com>
References: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
 <1452209679-19445-12-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <5115829.mX1Uk4EoYk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 January 2016 02:34:29 Yury Norov wrote:
> +
> +#include "../../../fs/compat_binfmt_elf.c"
> 

This is the wrong file, you have to include fs/binfmt_elf.c, otherwise
you pick up the same definitions that you have for the other one.

Alternatively, you can also change binfmt_elf32.c to include fs/binfmt_elf.c
and use fs/compat_binfmt_elf.c here if that makes the code nicer, you
just can use the compat file for both or things get ugly because of
the extra indirections.

	Arnd
