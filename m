From: noralf@tronnes.org (=?UTF-8?Q?Noralf_Tr=c3=b8nnes?=)
Date: Thu, 29 Sep 2016 00:10:37 +0200
Subject: [PATCH v3 7/7] i2c: bcm2835: Add support for dynamic clock
In-Reply-To: <87r383g1kb.fsf@eliezer.anholt.net>
References: <1475085056-5205-1-git-send-email-noralf@tronnes.org>
 <1475085056-5205-8-git-send-email-noralf@tronnes.org>
 <87r383g1kb.fsf@eliezer.anholt.net>
Message-ID: <05d1c9d8-644e-a2b1-2853-67b7b77f8509@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 28.09.2016 23:24, skrev Eric Anholt:
> Noralf Tr?nnes <noralf@tronnes.org> writes:
>
>> Support a dynamic clock by reading the frequency and setting the
>> divisor in the transfer function instead of during probe.
> Is this fixing some particular case you could note in the commit
> message?  As is, it makes me think that we should be using a notifier
> for when the parent clock (that's the one I assume you're talking about
> being dynamic) changes.  But maybe you're working around a variable VPU
> clock being set by the firmware, because we don't have a notifier for
> it?
>
> I'm a bit worried because I think this is going to be pretty expensive
> to be doing per transfer.

Actually I thought that this was a known problem, but trying to track
it down now, I can't find anything definitive. I don't have any tool
to look at the bus signals, so I couldn't actually test it.
Sorry about this, we can just drop this patch.

Noralf.
