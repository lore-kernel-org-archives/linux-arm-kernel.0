From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 19 Sep 2011 13:09:54 +0100
Subject: Link failures due to __bug_table in current -next
Message-ID: <20110919120954.GA20314@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm seeing linker failures in -next as of today:

`.exit.text' referenced in section `__bug_table' of fs/built-in.o:
defined in discarded section `.exit.text' of fs/built-in.o
`.exit.text' referenced in section `__bug_table' of crypto/built-in.o:
defined in discarded section `.exit.text' of crypto/built-in.o
`.exit.text' referenced in section `__bug_table' of net/built-in.o:
defined in discarded section `.exit.text' of net/built-in.o
`.exit.text' referenced in section `__bug_table' of net/built-in.o:
defined in discarded section `.exit.text' of net/built-in.o

which appears to be due to the chnage to use generic BUG() introduced in
commit 5254a3 (ARM: 7017/1: Use generic BUG() handler), reverting that
commit resolves the issue for me.

I'm wondering if we need something like 7c8a25 (CRIS: Discard exit.text
and .data at runtime) but figuring it out is a bit beyond my ld skills
right now.
