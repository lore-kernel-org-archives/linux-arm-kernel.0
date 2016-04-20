From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 20 Apr 2016 17:56:31 +0900
Subject: [PATCH] kbuild: drop redundant "PHONY += FORCE"
In-Reply-To: <20160420084710.GF15339@pobox.suse.cz>
References: <1460081770-29437-1-git-send-email-yamada.masahiro@socionext.com>
 <20160420084710.GF15339@pobox.suse.cz>
Message-ID: <CAK7LNATv51PRc9bGU7Q8_oTk9=C5ryfu7vMsKbG5drcgVbf1-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

2016-04-20 17:47 GMT+09:00 Michal Marek <mmarek@suse.cz>:
> On Fri, Apr 08, 2016 at 11:16:10AM +0900, Masahiro Yamada wrote:
>> "PHONY += FORCE" is already cared by scripts/Makefile.build,
>> which these files are included from.
>
> arch/ia64/Makefile is in fact included via the main Makefile. But this
> one also has the PHONY += FORCE statement. Maybe we should initialize
> PHONY with FORCE in Kbuild.include. Nevertheless, this patch is correct.
>
> Michal

Ah, right.

If it is not too late and you do not mind,
could you rephrase the git-log?

Like this?

----------------------->8------------------------------------
"PHONY += FORCE" is already cared by scripts/Makefile.build or the
top level Makefile, which these files are included from.
-----------------------8<------------------------------------



-- 
Best Regards
Masahiro Yamada
