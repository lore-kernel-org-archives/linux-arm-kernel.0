From: hch@lst.de (Christoph Hellwig)
Date: Wed, 1 Jul 2015 09:28:28 +0200
Subject: [PATCH v5 2/6] arch: unify ioremap prototypes and macro aliases
In-Reply-To: <CAMuHMdXqjmo2T3V=msZySVSu2j4YjyE7FnVXWTjySEyfYLSg1A@mail.gmail.com>
References: <20150622081028.35954.89885.stgit@dwillia2-desk3.jf.intel.com>
 <20150622082427.35954.73529.stgit@dwillia2-desk3.jf.intel.com>
 <20150622161002.GB8240@lst.de>
 <CAPcyv4h5OXyRvZvLGD5ZknO-YUPn675YGv0XdtW1QOO9qmZsug@mail.gmail.com>
 <20150701062352.GA3739@lst.de>
 <CAMuHMdUO4uSWH1Qc0SfDTLuXbiG2N9fq8Tf6j+3RoqVKdPugbA@mail.gmail.com>
 <20150701065948.GA4355@lst.de>
 <CAMuHMdXqjmo2T3V=msZySVSu2j4YjyE7FnVXWTjySEyfYLSg1A@mail.gmail.com>
Message-ID: <20150701072828.GA4881@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 09:19:29AM +0200, Geert Uytterhoeven wrote:
> >> So it would be the responsibility of the caller to fall back from
> >> ioremap(..., CACHED) to ioremap(..., UNCACHED)?
> >> I.e. all drivers using it should be changed...
> >
> > All of the zero users we currently have will need to be changed, yes.
> 
> Good. Less work to convert all of these ;-)

And I didn't have enough coffee yet.  We of course have a few users of
ioremap_cache(), and two implememantions but no users of ioremap_cached().
Looks like the implementations can't even agree on the name.
