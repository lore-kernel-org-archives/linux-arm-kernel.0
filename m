From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 08 Feb 2017 14:41:18 +0000
Subject: [PATCH 1/9] irqchip/gic-v3-its: Fix command buffer allocation
In-Reply-To: <20170201173833.12630-2-rrichter@cavium.com> (Robert Richter's
 message of "Wed, 1 Feb 2017 18:38:25 +0100")
References: <20170201173833.12630-1-rrichter@cavium.com>
 <20170201173833.12630-2-rrichter@cavium.com>
Message-ID: <87tw847njl.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01 2017 at  5:38:25 pm GMT, Robert Richter <rrichter@cavium.com> wrote:
> The its command buffer must be page aligned, but kzalloc() is not
> guaranteed to be (though it is mostly when allocating 64k). Use
> __get_free_pages() as this is used for other buffers as well.
>
> Signed-off-by: Robert Richter <rrichter@cavium.com>

I'm still going through this series, but as this is an obvious fix, I've
cherry-picked it for 4.11.

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.
