From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 8 Sep 2017 00:55:19 -0700
Subject: [PATCH v6 10/11] mm: add a user_virt_to_phys symbol
In-Reply-To: <20170907173609.22696-11-tycho@docker.com>
References: <20170907173609.22696-1-tycho@docker.com>
 <20170907173609.22696-11-tycho@docker.com>
Message-ID: <20170908075519.GD4957@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 07, 2017 at 11:36:08AM -0600, Tycho Andersen wrote:
> We need someting like this for testing XPFO. Since it's architecture
> specific, putting it in the test code is slightly awkward, so let's make it
> an arch-specific symbol and export it for use in LKDTM.

We really should not add an export for this.

I think you'll want to just open code it in your test module.
