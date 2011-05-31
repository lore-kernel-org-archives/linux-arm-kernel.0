From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 May 2011 23:18:25 +0200
Subject: [PATCH 2/3] clocksource: add DB8500 PRCMU Timer support
In-Reply-To: <4DE51EB7.7010606@stericsson.com>
References: <1306830661-9546-1-git-send-email-mattias.wallin@stericsson.com>
	<alpine.LFD.2.02.1105311236250.3078@ionos>
	<4DE51EB7.7010606@stericsson.com>
Message-ID: <BANLkTinPKbUu40066+wr3cdFRc2di-Uv6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2011 at 7:00 PM, Mattias Wallin
<mattias.wallin@stericsson.com> wrote:
> On 05/31/2011 12:38 PM, Thomas Gleixner wrote:

>>> +++ b/include/linux/clksrc-db8500-prcmu.h

>> Huch, why needs this to be a separate head in include/linux ?
>
> I will move the header file to mach-ux500/include/mach/. Ok?
>
> (I have long time ago been thought to avoid include mach headers from the
> drivers. But if I understand it correct it is not true any more and in this
> case it certainly makes no sense since I break that rule myself.)

Keeping it under include/linux is probably wise since we want drivers
OUT of the ARM tree, but I don't know if there is much consensus on that?

I was more understanding the question as why it was needed at all.

Does it work to register the clocksource with say a core_initcall()
and avoid the header altogether?

Else a header is needed since we need to call out from the platform timer
init function to this clocksource to register it.

Thanks,
Linus Walleij
