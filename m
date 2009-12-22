From: bonzini@gnu.org (Paolo Bonzini)
Date: Tue, 22 Dec 2009 12:33:34 +0100
Subject: [PATCH] ARM: Convert BUG() to use unreachable()
In-Reply-To: <84fc9c000912170917y4b2772d0n47bb4dabc74b91ef@mail.gmail.com>
References: <1260266138-17684-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091217150120.GD24967@shareable.org>
	<4B2A65C6.7080009@caviumnetworks.com>
	<84fc9c000912170917y4b2772d0n47bb4dabc74b91ef@mail.gmail.com>
Message-ID: <4B30AE8E.8060805@gnu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2009 06:17 PM, Richard Guenther wrote:
> It shouldn't as *(int *)0 = 0; might trap.  But if you want to be sure
> use
>     __builtin_trap ();
> instead for the whole sequence (the unreachable is implied then).
> GCC choses a size-optimal trap representation for your target then.

Agree that it shouldn't but just to be sure I'd use

   *(volatile int *)0 = 0;
   unreachable ();

Paolo
