From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 6 Dec 2011 10:34:57 +0000
Subject: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
In-Reply-To: <20111206093000.GA2274@linaro.org>
References: <20111202192618.GC3037@localhost.localdomain>
 <CA+55aFwekNWz+V4440f=2iu_BfOxSg0NjVogv4cZZDFbJBNoAQ@mail.gmail.com>
 <1322867573.11728.22.camel@pasglop>
 <20111205161157.GA27550@localhost.localdomain>
 <alpine.LFD.2.02.1112051236350.2357@xanadu.home>
 <20111205180253.GB29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051310150.2357@xanadu.home>
 <4EDD1897.4030208@gmail.com>
 <20111205202125.GA32592@oksana.dev.rtsoft.ru>
 <4EDD2DE1.1050606@gmail.com> <20111206093000.GA2274@linaro.org>
Message-ID: <20111206103457.1c662b6d@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Otherwise, it feels like we might need a strategy for migrating pretty
> much everything if we don't want to end up in a mess.

You really do anyway - lots of generic driver code knows !dev->irq is a
valid test. That covers things like 8250 based UART hardware, network phy
layer code and vast amounts more.

The bugs will already be there because ARM isn't using 0, they just
aren't getting seen or aren't getting hit.

Alan
