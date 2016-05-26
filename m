From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 26 May 2016 05:06:35 -0700
Subject: [RFC][PATCH 1/3] staging: ion: Move away from the DMA APIs for
 cache flushing
In-Reply-To: <20160526105922.GH19428@n2100.arm.linux.org.uk>
References: <1464205684-5587-1-git-send-email-labbott@redhat.com>
 <1464205684-5587-2-git-send-email-labbott@redhat.com>
 <20160526095835.GT23566@e106497-lin.cambridge.arm.com>
 <20160526105922.GH19428@n2100.arm.linux.org.uk>
Message-ID: <20160526120635.GA28564@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2016 at 11:59:22AM +0100, Russell King - ARM Linux wrote:
> I _really_ hate seeing architecture internal functions being abused in
> drivers - architecture internal functions are there to implement the
> official kernel APIs and are not for drivers to poke about with.

Exactly - if drivers like drm and ion want to do something out side the
current DMA API we need to add a proper API, not hack around the lack of
one.
