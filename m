From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 12 Jan 2016 19:46:41 +0300
Subject: [PATCH v6 11/21] arm64: ilp32: introduce binfmt_ilp32.c
In-Reply-To: <5115829.mX1Uk4EoYk@wuerfel>
References: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
 <1452209679-19445-12-git-send-email-ynorov@caviumnetworks.com>
 <5115829.mX1Uk4EoYk@wuerfel>
Message-ID: <20160112164641.GA9246@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 10:08:44AM +0100, Arnd Bergmann wrote:
> On Friday 08 January 2016 02:34:29 Yury Norov wrote:
> > +
> > +#include "../../../fs/compat_binfmt_elf.c"
> > 
> 
> This is the wrong file, you have to include fs/binfmt_elf.c, otherwise
> you pick up the same definitions that you have for the other one.
> 

I chose compat as it's how it wokrs now. It redefines some types like
user_long_t, and I think it's neccessary for ILP32, as for aarch32.

> Alternatively, you can also change binfmt_elf32.c to include fs/binfmt_elf.c
> and use fs/compat_binfmt_elf.c here if that makes the code nicer, you
> just can use the compat file for both or things get ugly because of
> the extra indirections.
> 
> 	Arnd
