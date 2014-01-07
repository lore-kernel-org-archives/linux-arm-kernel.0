From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Tue, 7 Jan 2014 15:47:19 -0200
Subject: [PATCH v3 01/13] clk: sunxi: register factors clocks behind
 composite
In-Reply-To: <52CC31CD.2060005@overkiz.com>
References: <1387769564-12894-1-git-send-email-emilio@elopez.com.ar>
 <1387769564-12894-2-git-send-email-emilio@elopez.com.ar>
 <52CC31CD.2060005@overkiz.com>
Message-ID: <CAAoKrfo+xOoc=S2wJF9XWz3OJoCOG3jD_m5N3XTSWOY6c1LR7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

[ Apologies if the email looks weird and for using a link; I'm not
using my typical email client ]

> I'm currently working on the sunxi NFC (Nand Flash Controller) driver
> and I need to set the NAND clk (which is a mod0 clk type) rate.
>
> It seems that the composite clk fallbacks to the mux_hw's determine_rate
> instead of calling the rate_hw's (or factors hw) round_rate, if rate_hw
> does not implement determine_rate.

That is to be expected; if you have a composite clock that has all
fixed parents you'd not implement the determine_rate on the rate
component but on the mux one.

(...)

> But anyway, I think there is a drawback in the way composite clk
> implement the determine_rate handler.
> Mike, shouldn't we choose the best parent (using mux) fullfilling the
> rate_hw needs ?

Someone using the composite clock may not want their clocks to start
changing parents though. I believe it's easier and better to just
implement determine_rate as on this patch on my tree (which I haven't
sent yet, but it's literally the next in queue.)

http://git.elopez.com.ar/linux/commits/5b4eb3ac406b9c98965714d40e8dd6da943d1ab0

Let me know if that resolves your issue.

Cheers,

Emilio
