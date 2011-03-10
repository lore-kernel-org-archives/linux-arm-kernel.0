From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 10 Mar 2011 07:45:15 -0700 (MST)
Subject: [PATCH] OMAP4: hwmod: Disable hardware-controlled idle for
 GPT1
In-Reply-To: <3b8b985f13158fbcd110cf45ed7035ad@mail.gmail.com>
References: <alpine.DEB.2.00.1103091847150.15132@utopia.booyaka.com>
	<alpine.DEB.2.00.1103100143230.15132@utopia.booyaka.com>
	<3b8b985f13158fbcd110cf45ed7035ad@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1103100744500.15132@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Mar 2011, Santosh Shilimkar wrote:

> We continued further debug on the static dependency issues with
> OMAP4 PM series.
> So far from the findings what I have, this timer patch is actually not
> needed and can be dropped. Infact the patch is not really effective
> because current timer driver(not hwmod adapted yet) puts timer1
> in smart idle again.
> 
> There is another static dep. just like MPUSS<-->EMIF seems to create
> an issue. The lock-up is not very consistently reproducible so it's
> very easy to get miss-leading results. Timer patch was one of those
> observations. With or without timer patch I can reproduce the hang
> with long duration test.
> 
> Will keep narrowing down the next offending static dependency but
> in mean time I suggest you to drop this patch.

Okay, dropped.


- Paul
