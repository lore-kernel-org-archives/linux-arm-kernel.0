From: mmarek@suse.cz (Michal Marek)
Date: Wed, 20 Apr 2016 10:47:10 +0200
Subject: [PATCH] kbuild: drop redundant "PHONY += FORCE"
In-Reply-To: <1460081770-29437-1-git-send-email-yamada.masahiro@socionext.com>
References: <1460081770-29437-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160420084710.GF15339@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 08, 2016 at 11:16:10AM +0900, Masahiro Yamada wrote:
> "PHONY += FORCE" is already cared by scripts/Makefile.build,
> which these files are included from.

arch/ia64/Makefile is in fact included via the main Makefile. But this
one also has the PHONY += FORCE statement. Maybe we should initialize
PHONY with FORCE in Kbuild.include. Nevertheless, this patch is correct.

Michal
