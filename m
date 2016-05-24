From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 24 May 2016 02:09:38 -0700
Subject: [PATCH 0/4] dma-mapping: Constify dma_attrs
In-Reply-To: <1464071290-15948-1-git-send-email-k.kozlowski@samsung.com>
References: <1464071290-15948-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160524090938.GA13166@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I think this is moving into the wrong direction.  The right fix here
is to get of all the dma_attrs boilerplate code and just replace it
with a simple enum dma_flags.  This would simplify both the callers
and most importantly the wrappers for the flag-less versions a lot.
