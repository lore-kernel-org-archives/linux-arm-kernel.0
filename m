From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 21 Jul 2015 09:11:29 -0700
Subject: [PATCH 08/10] arch: introduce strict_ioremap
In-Reply-To: <20150721133051.GB8902@lst.de>
References: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150720001817.30857.69287.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150721133051.GB8902@lst.de>
Message-ID: <CAPcyv4gsvLmB9QPP=C6RqXuyWeBF_JyubnLypUnoEhJiQL0hbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 21, 2015 at 6:30 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Sun, Jul 19, 2015 at 08:18:17PM -0400, Dan Williams wrote:
>> In preparation for enabling memremap(), add support for strict mappings.
>> strict_ioremap_<type>() returns NULL if the arch does not implement the
>> mapping type, rather than falling back silently to ioremap().
>
> Please don't introduce another large number of ioremap variants.
>
> I think we should go straight to the ioremap_flags variant, although
> I wonder if we should even bother with ioremap_flags for this use
> case, given that we really want memremap-like semantics for anything
> that isn't plain ioremap (and maybe ioremap_nocache).
>
> Sorry or being the downer, but I really think we need to clean up this
> mess deeply insted of trying to paper over it.

No worries.  I'll rework the series around the idea that memremap() is
a replacement rather than a wrapper for ioremap_<type>().
