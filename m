From: b.brezillon@overkiz.com (Boris Brezillon)
Date: Tue, 07 Jan 2014 21:46:18 +0100
Subject: [PATCH v3 01/13] clk: sunxi: register factors clocks behind
 composite
In-Reply-To: <CAAoKrfo+xOoc=S2wJF9XWz3OJoCOG3jD_m5N3XTSWOY6c1LR7w@mail.gmail.com>
References: <1387769564-12894-1-git-send-email-emilio@elopez.com.ar>
 <1387769564-12894-2-git-send-email-emilio@elopez.com.ar>
 <52CC31CD.2060005@overkiz.com>
 <CAAoKrfo+xOoc=S2wJF9XWz3OJoCOG3jD_m5N3XTSWOY6c1LR7w@mail.gmail.com>
Message-ID: <946d982e-e207-4ab4-a9da-02df1938ffa7@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



"Emilio L?pez" <emilio@elopez.com.ar> a ?crit?:
>Hi Boris,
>
>[ Apologies if the email looks weird and for using a link; I'm not
>using my typical email client ]
>
>> I'm currently working on the sunxi NFC (Nand Flash Controller) driver
>> and I need to set the NAND clk (which is a mod0 clk type) rate.
>>
>> It seems that the composite clk fallbacks to the mux_hw's
>determine_rate
>> instead of calling the rate_hw's (or factors hw) round_rate, if
>rate_hw
>> does not implement determine_rate.
>
>That is to be expected; if you have a composite clock that has all
>fixed parents you'd not implement the determine_rate on the rate
>component but on the mux one.
>

Right, but this is not the case for mod0 
clks, is it ?

>(...)
>
>> But anyway, I think there is a drawback in the way composite clk
>> implement the determine_rate handler.
>> Mike, shouldn't we choose the best parent (using mux) fullfilling the
>> rate_hw needs ?
>
>Someone using the composite clock may not want their clocks to start
>changing parents though. I believe it's easier and better to just
>implement determine_rate as on this patch on my tree (which I haven't
>sent yet, but it's literally the next in queue.)
>

Fair enough (I did pretty much the same thing in my first attempt to fix this bug ;-))


>http://git.elopez.com.ar/linux/commits/5b4eb3ac406b9c98965714d40e8dd6da943d1ab0
>
>Let me know if that resolves your issue.

I'll try it tomorrow.

BTW, I managed to get a working NAND driver (without DMA and hw ECC).

I'll post it on the ML soon (just need to clean it up a little bit).

Best regards,

Boris

>
>Cheers,
>
>Emilio
