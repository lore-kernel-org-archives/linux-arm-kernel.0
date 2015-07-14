From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 14 Jul 2015 23:32:51 +0200
Subject: [PATCH] ARM: pxa: Use setup_timer
In-Reply-To: <20150611052734.GA3943@vaishali-Ideapad-Z570> (Vaishali Thakkar's
 message of "Thu, 11 Jun 2015 10:57:35 +0530")
References: <20150611052734.GA3943@vaishali-Ideapad-Z570>
Message-ID: <87lheijugs.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vaishali Thakkar <vthakkar1994@gmail.com> writes:

> Use the timer API function setup_timer instead of structure field
> assignments to initialize a timer.
>
> A simplified version of the Coccinelle semantic patch that performs
> this transformation is as follows:
>
> @change@
> expression e1, e2, a;
> @@
>
> -init_timer(&e1);
> +setup_timer(&e1, a, 0UL);
> ... when != a = e2
> -e1.function = a;
>
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
Looks good to me.
I'll queue that in pxa/for-next, thanks.

Cheers.

-- 
Robert
