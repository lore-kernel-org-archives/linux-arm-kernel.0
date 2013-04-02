From: dgilbert@interlog.com (Douglas Gilbert)
Date: Tue, 02 Apr 2013 11:32:27 -0400
Subject: [RFC PATCH] rtc: rtc-at91rm9200: manage IMR depending on revision
In-Reply-To: <1364908007-5150-1-git-send-email-nicolas.ferre@atmel.com>
References: <1364573029-19346-5-git-send-email-jhovold@gmail.com>
 <1364908007-5150-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <515AFA0B.7020509@interlog.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-04-02 09:06 AM, Nicolas Ferre wrote:
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Hi all,
>
> The funny thing is that I was writing exactly the same code as Johan's
> when he posted his series.
>
> So, here is my single patch, with the comment about the readback stolen from
> Johan's, but without the way to determine with IP is buggy and which one is
> not...
> After having dug the possibility to read the IP revision, I discovered that it
> is not possible to use this information ("version" register offset changing
> according to... IP version number: well done!).
> In conclusion, I guess that the only way to determine if we need the workaround
> is to use the DT.
> One remark though: if we use the compatibility string for this purpose, I fear
> that we would twist the meaning of this information: SoC using an
> "atmel,at91sam9x5-rtc" compatible RTC will not necessarily be touched by the
> "non responding IMR" bug: at91sam9n12 or upcoming sama5d3 are not affected for
> instance, and we need to cling to "atmel,at91rm9200-rtc" for them...
> I think that we can use this method for the moment and move to another
> compatibility string later if it is needed.

Rather than have so many people working on rtc-at91rm9200.c,
how about someone bring its "RTT" sibling into the DT
world. I'm talking about drivers/rtc/rtc-at91sam9.c ...

Doug Gilbert
