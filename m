From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 6 Dec 2011 11:34:58 +0000
Subject: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
In-Reply-To: <20111206061321.GH9192@game.jcrosoft.org>
References: <20111110162859.GA7088@oksana.dev.rtsoft.ru>
 <20111202192618.GC3037@localhost.localdomain>
 <CA+55aFwekNWz+V4440f=2iu_BfOxSg0NjVogv4cZZDFbJBNoAQ@mail.gmail.com>
 <1322867573.11728.22.camel@pasglop>
 <20111205161157.GA27550@localhost.localdomain>
 <alpine.LFD.2.02.1112051236350.2357@xanadu.home>
 <20111205180253.GB29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051310150.2357@xanadu.home>
 <20111205184522.316598de@lxorguk.ukuu.org.uk>
 <20111206061321.GH9192@game.jcrosoft.org>
Message-ID: <20111206113458.1c247d79@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> can we sinply introduce a macro irq_is_valid

See the 2005, 2006 and 2008 discussion.

    if (!dev->irq)

is the proper test.

The <= is just a temporary thing while ARM gets its publically visible
house in order so it can be done without breakage.

Alan
