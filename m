From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 5 Oct 2010 22:04:14 +0200
Subject: [PATCH v2] i.MX31 and i.MX35 : fix errate TLSbo65953 and
	ENGcm09472
In-Reply-To: <4CAB83C2.3040301@eukrea.com>
References: <20101005094510.GJ28242@pengutronix.de>
	<1286280012-19809-1-git-send-email-eric@eukrea.com>
	<20101005183308.GX11737@pengutronix.de>
	<4CAB7D0F.9020600@eukrea.com>
	<20101005194659.GY11737@pengutronix.de>
	<4CAB83C2.3040301@eukrea.com>
Message-ID: <20101005200414.GA11737@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eric,

>> Hmm, when the caches are off before entering wfi, does that mean that
>> all interrupt (and fiq) handlers run with the caches off, too?  That's
>> very bad, isn't it?
>>
> If I understand well, this case happens only when they run after WFI  
> which means cpuidle was called (and thus CPU activity was null for a  
> certain amount of time, which explains why it's easier to reproduce the  
> problem with tslib than with qtdemo which takes 100% CPU and don't let  
> cpuidle to execute very often).
>
> That may seems bad, but I find this solution better than having an oops  
> after a few IRQs which makes the CPU unusable for real life applications 
> :-)
Ack, but it makes me think if the caches should be enabled in the irq
entry point, too.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
