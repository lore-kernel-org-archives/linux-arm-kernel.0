From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 20 Jul 2011 04:49:33 +0200
Subject: [PATCH v5] Consolidate SRAM support
In-Reply-To: <1310300379-2882-1-git-send-email-plagnioj@jcrosoft.com>
References: <1310300379-2882-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20110720024933.GC15388@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:19 Sun 10 Jul     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> 
> We have two SoCs using SRAM, both with their own allocation systems,
> and both with their own ways of copying functions into the SRAM.
> 
> Let's unify this before we have additional SoCs re-implementing this
> obviously common functionality themselves.
> 
> For this use the generic allocator and the newly introduce
> gen_pool_add_virt and gen_pool_virt_to_phys
> 
> Uio_pruss should probably take the SRAM pool pointer via
> platform data so that it doesn't have to include Davinci specific
> includes.
Russell can I have a go?

Best Regards,
J.
