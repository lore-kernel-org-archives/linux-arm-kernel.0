From: jakob@viketoft.se (Jakob Viketoft)
Date: Tue, 20 Apr 2010 17:20:37 +0200
Subject: SPI trouble on Colibri 270 (PXA)...
In-Reply-To: <q2sf17812d71004200614n58fb6cabgd0686d3ab6788b23@mail.gmail.com>
References: <4BCD96F0.5010506@viketoft.se>
	<q2sf17812d71004200614n58fb6cabgd0686d3ab6788b23@mail.gmail.com>
Message-ID: <4BCDC645.5090001@viketoft.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao wrote:
> On Tue, Apr 20, 2010 at 7:58 PM, Jakob Viketoft <jakob@viketoft.se> wrote:
<...>
>> I haven't seen any other board using the same combination (the m25p80 and
>> the pxa2xx), but I'm still opting for an error on my part somewhere. I've
>> attached my SPI configuration (board setup) in the end of the mail.
>>
> 
> Not looked into m25p80 code, but CS is normally asserted before a transfer
> begins and deasserted after a transfer is done. I doubt there are some cases
> where the transfer is not set up correctly.

Well, in this case when doing a read you must set up a write transfer to 
write the read command + address and then a read transfer to actually 
read back the data. In this case the cs musn't be deasserted between 
transfers because this means the operation is terminated.

> Actually, cs_assert() and cs_deassert() are there in pxa2xx_spi.c as two very
> good debugging point to print out the transfer information to see if they are
> setup correctly.

When I look at how these two are used I get a an serie of assert, 
assert, deassert for each read operation (which should be correct 
behaviour). This suggests that something else is deasserting the cs or 
that the CPU is doing something on it's own accord. Hmmm...

Regards,

	/Jakob
