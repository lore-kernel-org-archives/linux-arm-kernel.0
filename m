From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 27 Jul 2013 09:47:53 +1000
Subject: [GIT PULL] arm64 fixes for 3.11
In-Reply-To: <CA+55aFzmEhGvqY883Bg568Gguewy41X9n1qDeaHkW2We6VVhZg@mail.gmail.com>
References: <20130726155458.GA31613@arm.com>
 <CA+55aFzmEhGvqY883Bg568Gguewy41X9n1qDeaHkW2We6VVhZg@mail.gmail.com>
Message-ID: <1374882473.9200.33.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-07-26 at 12:54 -0700, Linus Torvalds wrote:
> 
> *Some* other 64-bit architectures do 16k stack sizes. But neither
> x86-64 nor powerpc do, afaik. Instead, they do irq stacks, which is
> generally a better idea than having one big stack.

Sadly you over estimated us here :-) We do 16K *and* irq stacks on
64-bit ... Remember our ABI with it's 112 bytes minimum per frame ?

It's been a while since I've last audited our actual usage mind you, we
*might* be able to reduce it but at this stage, since our typical
configs use a 64K base page size, it's not a big deal (ie, it's not an
order-N allocation).

Cheers,
Ben.
