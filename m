From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 16 Aug 2017 14:09:21 +0200
Subject: [PATCH 3/5] reset: Add Realtek RTD1295 driver
In-Reply-To: <1502876699.7596.3.camel@pengutronix.de>
References: <20170816003847.6208-1-afaerber@suse.de>
 <20170816003847.6208-4-afaerber@suse.de>
 <1502876699.7596.3.camel@pengutronix.de>
Message-ID: <47359100-edf7-5aa4-a3ee-1250c8a84c5e@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

Am 16.08.2017 um 11:44 schrieb Philipp Zabel:
> On Wed, 2017-08-16 at 02:38 +0200, Andreas F?rber wrote:
>> Add a per-register reset controller driver. This deals with the fact
>> that not all registers are adjoined.
> 
> the way you handle the non-contiguous reset registers, this looks like
> a candidate to join the recently discussed reset-simple driver [1].
> Could you check if that would fit?

Thanks, I appreciate the idea, and it looks like you already have the
active-low logic in place.

Are you okay with keeping the first three as separate nodes, or would
you rather want one node to cover the first three registers, plus two
separate ones for the non-contiguous cases? Or is the simple driver
supposed to cover gaps, too? Then we could go with just two nodes. (I
found it weird to have reset and then reset4, so I went with separate
ones as seen downstream.)

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
