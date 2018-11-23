From: hch@lst.de (Christoph Hellwig)
Date: Fri, 23 Nov 2018 07:55:11 +0100
Subject: remove the ->mapping_error method from dma_map_ops V2
In-Reply-To: <CAHk-=whxf0zqutExPr_j1A625Z3gcL6k_ABzKo1BtzN4F93hkA@mail.gmail.com>
References: <20181122140320.24080-1-hch@lst.de>
 <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
 <20181122170715.GI30658@n2100.armlinux.org.uk>
 <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
 <11829e3c-7302-f821-cf5c-863e5267a17b@arm.com>
 <CAHk-=whxf0zqutExPr_j1A625Z3gcL6k_ABzKo1BtzN4F93hkA@mail.gmail.com>
Message-ID: <20181123065511.GA17856@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 09:55:25AM -0800, Linus Torvalds wrote:
> No, the big immediate benefit of allowing "return -EINVAL" etc is
> simply legibility and error avoidance.

Well, I can tweak the last patch to return -EINVAL from dma_mapping_error
instead of the old 1 is as bool true.  The callers should all be fine,
although I'd have to audit them.  Still wouldn't help with being able to
return different errors.
