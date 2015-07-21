From: hch@lst.de (Christoph Hellwig)
Date: Tue, 21 Jul 2015 15:30:51 +0200
Subject: [PATCH 08/10] arch: introduce strict_ioremap
In-Reply-To: <20150720001817.30857.69287.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150720001817.30857.69287.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <20150721133051.GB8902@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 19, 2015 at 08:18:17PM -0400, Dan Williams wrote:
> In preparation for enabling memremap(), add support for strict mappings.
> strict_ioremap_<type>() returns NULL if the arch does not implement the
> mapping type, rather than falling back silently to ioremap().

Please don't introduce another large number of ioremap variants.

I think we should go straight to the ioremap_flags variant, although
I wonder if we should even bother with ioremap_flags for this use
case, given that we really want memremap-like semantics for anything
that isn't plain ioremap (and maybe ioremap_nocache).

Sorry or being the downer, but I really think we need to clean up this
mess deeply insted of trying to paper over it.
