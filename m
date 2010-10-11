From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Mon, 11 Oct 2010 15:19:23 +0200
Subject: [PATCH] mxc/gpio: make _set_value work with values != 0/1
In-Reply-To: <87fwwcor79.fsf@macbook.be.48ers.dk>
References: <1286798345-32647-1-git-send-email-jacmet@sunsite.dk>
	<20101011121511.GY29673@pengutronix.de>
	<87fwwcor79.fsf@macbook.be.48ers.dk>
Message-ID: <op.vkexyla47p4s8u@pikus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Oct 2010 14:21:30 +0200, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> Se my other reply. I don't feel strongly about it, but I for one don't
> remember the precedence rules for !! and << offhand.

A bit off-topic, but hopefuly it'll help someone:

1. (In C,) one argument operators have binding tighter than two (or three) argument
    operators. (The only exception to this rule is the :: operator in C++ which has
    the tighest binding of all operators.)
2. The next rule, is that one argument postfix operators has tigter binding
    then prefix operators, thus *a++ is *(a++).

I find those two rules let me understand most operatrs use cases.  Hope this
helps. :)


Also, I haven't followed the patch from the beginnig (just stumbled accross
some mails), but anoter possible solution to the problem would be to change
the type of "value" to "bool".

-- 
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=./ `o
| Computer Science,  Micha? "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
