From: b.brezillon@overkiz.com (boris brezillon)
Date: Wed, 08 Jan 2014 10:30:48 +0100
Subject: [PATCH v3 01/13] clk: sunxi: register factors clocks behind
 composite
In-Reply-To: <CAAoKrfo+xOoc=S2wJF9XWz3OJoCOG3jD_m5N3XTSWOY6c1LR7w@mail.gmail.com>
References: <1387769564-12894-1-git-send-email-emilio@elopez.com.ar>	<1387769564-12894-2-git-send-email-emilio@elopez.com.ar>	<52CC31CD.2060005@overkiz.com>
 <CAAoKrfo+xOoc=S2wJF9XWz3OJoCOG3jD_m5N3XTSWOY6c1LR7w@mail.gmail.com>
Message-ID: <52CD1AC8.9060801@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2014 18:47, Emilio L?pez wrote:
> Hi Boris,
>
> [ Apologies if the email looks weird and for using a link; I'm not
> using my typical email client ]
>
>> I'm currently working on the sunxi NFC (Nand Flash Controller) driver
>> and I need to set the NAND clk (which is a mod0 clk type) rate.
>>
>> It seems that the composite clk fallbacks to the mux_hw's determine_rate
>> instead of calling the rate_hw's (or factors hw) round_rate, if rate_hw
>> does not implement determine_rate.
> That is to be expected; if you have a composite clock that has all
> fixed parents you'd not implement the determine_rate on the rate
> component but on the mux one.
>
> (...)
>
>> But anyway, I think there is a drawback in the way composite clk
>> implement the determine_rate handler.
>> Mike, shouldn't we choose the best parent (using mux) fullfilling the
>> rate_hw needs ?
> Someone using the composite clock may not want their clocks to start
> changing parents though. I believe it's easier and better to just
> implement determine_rate as on this patch on my tree (which I haven't
> sent yet, but it's literally the next in queue.)
>
> http://git.elopez.com.ar/linux/commits/5b4eb3ac406b9c98965714d40e8dd6da943d1ab0
>
> Let me know if that resolves your issue.

Yes, it works.
Thanks.

Can you submit it on LAKML so that I can state the dependency in my
NFC driver series ?

Best Regards,

Boris

>
> Cheers,
>
> Emilio
