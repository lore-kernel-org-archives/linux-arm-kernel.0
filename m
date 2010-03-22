From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 22 Mar 2010 22:09:00 +0100
Subject: PXA3xx internal SRAM
In-Reply-To: <20100321124739.GG30801@buzzloop.caiaq.de>
References: <20100321124739.GG30801@buzzloop.caiaq.de>
Message-ID: <63386a3d1003221409j63413b5o7a0515836eaa8b86@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/3/21 Daniel Mack <daniel@caiaq.de>:

> I wonder what this could be used for. Is there any kind of cache that
> would be worth putting there to speed up things for example?

Some ARM systems have TCM (Tightly Coupled Memory) which are similar
in character but actually a feature of the ARM platforms rather than a custom
memory for a certain SoC.

You can find some documentation on how this can be used in
Documentation/arm/tcm.txt, as you can see we can compile code there
and the memory left after that can be used as a generic memory pool
for fast always-on memory.

I raised the question as to whether the IRQ vectors could be put into
this memory but Russell says this is unfortunately not possible, because
the top of the vector page is also used for other things. I don't know if
this entire page can be moved to fast memory though, perhaps that
concept need to be revisited?

Linus Walleij
