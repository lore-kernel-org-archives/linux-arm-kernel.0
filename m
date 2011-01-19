From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 20 Jan 2011 00:52:33 +0100
Subject: [PATCH] mmci: fixup broken_blockend variant patch v2
In-Reply-To: <20110119205158.GC6335@n2100.arm.linux.org.uk>
References: <1295275071-13146-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTin67iTj34QBv3T-9+oMdo6q=EsYKf=5ca=6B69s@mail.gmail.com>
	<4D346800.3070603@stericsson.com>
	<20110118121455.GB9719@n2100.arm.linux.org.uk>
	<AANLkTineFJhqMcJbg1YQbPymT537Ef=jVgXLC5uw7DOt@mail.gmail.com>
	<20110119205158.GC6335@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimGmGStr8wHbJhkOsPcrWQmLFFQQCpgizE8+joj@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/19 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Wed, Jan 19, 2011 at 09:34:49PM +0100, Linus Walleij wrote:
>> 2011/1/18 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>>
>> > How reliable is the FIFOCNT register ?
>>
>> Hmm... the FIFOCNT is just the FIFO.
>
> No, FIFOCNT.
>
> ?The MCIFifoCnt register contains the remaining number of words to be
> ?written to or read from the FIFO.

Yeah I B damned that's right. Sorry for the confusion. I'll respin
the latest patch on the FIFOCNT register instead and test
tomorrow.

But if the transfer is complete, MCIDataCnt should be valid
as well. I'll read the datasheet(s) closer and see if I get some
useful clues about which one is more reliable in the error
case.

Sorry for late night confusion...
Linus Walleij
