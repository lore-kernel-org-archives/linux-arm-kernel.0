From: marex@denx.de (Marek Vasut)
Date: Wed, 4 Jul 2012 05:47:36 +0200
Subject: MX28 poweroff issue
In-Reply-To: <CAOMZO5Ab-Zibnn-tVfTz5BNJsqJer88jZLVa5Een9DDZ3tdssg@mail.gmail.com>
References: <201207040030.36713.marex@denx.de>
 <201207040412.46748.marex@denx.de>
 <CAOMZO5Ab-Zibnn-tVfTz5BNJsqJer88jZLVa5Een9DDZ3tdssg@mail.gmail.com>
Message-ID: <201207040547.37021.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> On Tue, Jul 3, 2012 at 11:12 PM, Marek Vasut <marex@denx.de> wrote:
> > Dunno, can you try on mx28 please?
> 
> I get the same crash as you reported.
> 
> On a mx27 (also ARM926EJS) I do not see this problem.

Thanks for verifying this, Fabio. The mx28 generates timer interrupt after it 
should be sitting in the endless loop, therefore this crash. I think it's 
because the mx28 (mxs at al) is using the new clock framework (compared to mxc) 
and the timer isn't deinited by then ...

Disabling interrupts might be just the right solution, though I'm not sure if 
it's not hiding bugs ...

> Regards,
> 
> Fabio Estevam

Best regards,
Marek Vasut
