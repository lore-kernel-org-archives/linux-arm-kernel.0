From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 27 Jan 2011 15:16:51 +0100
Subject: [PATCH] mmci: fixup broken_blockend variant patch v2
In-Reply-To: <20110127110603.GA25968@n2100.arm.linux.org.uk>
References: <1295275071-13146-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTin67iTj34QBv3T-9+oMdo6q=EsYKf=5ca=6B69s@mail.gmail.com>
	<4D346800.3070603@stericsson.com>
	<20110118121455.GB9719@n2100.arm.linux.org.uk>
	<AANLkTineFJhqMcJbg1YQbPymT537Ef=jVgXLC5uw7DOt@mail.gmail.com>
	<20110119205158.GC6335@n2100.arm.linux.org.uk>
	<AANLkTimGmGStr8wHbJhkOsPcrWQmLFFQQCpgizE8+joj@mail.gmail.com>
	<AANLkTim4i8BibVFmn2C4ixRoMrX5mNU9HZjW2KGMXsYZ@mail.gmail.com>
	<20110127110603.GA25968@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinDYooNRYkToqj_CxYOKj0nMDuxo53D3hPuD2_p@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/27 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> Something occurs to me - isn't DATACNT a byte counter rather than a word
> counter?

It is.

> I think that's something which needs to be confirmed. ?The TRM
> is a little confusing: (...)
>
> I think this requires some experimentation...

All experiments I've done by ejecting the card while reading seem to
have the transfer end on thing like 0xc00, 0x800, 0x1000 etc, all
even multiples of 512 bytes.

I have also read the VHDL code, which is shows it is clearly
a byte counter.

Found another bug as well when calculating the number of bytes
left, so sent off a patch.

Linus Walleij
