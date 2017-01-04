From: eric@anholt.net (Eric Anholt)
Date: Wed, 04 Jan 2017 10:16:06 -0800
Subject: [PATCH 1/2] mmc: sdhci-iproc: Apply caps from bcm2835-mmc driver
In-Reply-To: <1751352115.251342.1483474996021@email.1und1.de>
References: <1483111474-29907-1-git-send-email-stefan.wahren@i2se.com>
 <1483111474-29907-2-git-send-email-stefan.wahren@i2se.com>
 <87lgusngn7.fsf@eliezer.anholt.net>
 <1751352115.251342.1483474996021@email.1und1.de>
Message-ID: <871swi8zdl.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Eric,
>
>> Eric Anholt <eric@anholt.net> hat am 3. Januar 2017 um 19:27 geschrieben:
>> 
>> 
>> Stefan Wahren <stefan.wahren@i2se.com> writes:
>> 
>> > Since the mmc module on bcm2835 neither provide a capabilities register nor 
>> > free documentation we must rely on the downstream implementation [1].
>> 
>> Yeah, caps reg is wired to 0, but it can do high speed.
>> 
>> Since we're VDD_330 only, I'm not sure the driver type flags do
>> anything, but I'm still good with having consistency.
>
> yes, the driver type flags currently have no benefit.
>
>> 
>> Reviewed-by: Eric Anholt <eric@anholt.net>
>> 
>> Interested in porting over the DMA support? :)
>
> AFAIK the sdhci doesn't support external DMA (required for bcm2835).
> So DMA support would result in a new driver, which i'm currently not interested.
>
> But i've prepared a fixup patch series for the sdhost driver i want to send to Gerd.
>
>> 
>> I also noticed that the emmc wrapper module claims it can run with a
>> clock from 50-100mhz, and the arasan says it can run at up to 50, 52, or
>> 208mhz depending on SD/MMC mode.  Could we get a boost from running the
>> module at a higher clock rate?
>
> Sorry, i can't follow. Do you mean DDR mode?

Apparently I what I was reading about was SDR104 mode, which also
requires 1.8V.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170104/2cf80251/attachment.sig>
