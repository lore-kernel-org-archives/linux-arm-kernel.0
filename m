From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Jul 2012 17:36:24 +0100
Subject: [PATCH v2] arm: Handle >4GB memory sizes in device tree and
 mem=size@start option
In-Reply-To: <1341999588-32544-1-git-send-email-peter.maydell@linaro.org>
References: <1341999588-32544-1-git-send-email-peter.maydell@linaro.org>
Message-ID: <20120712163624.GP2816@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 10:39:48AM +0100, Peter Maydell wrote:
> The memory regions which are passed to arm_add_memory() from
> device tree blobs via early_init_dt_add_memory_arch() can
> have sizes which are larger than will fit in a 32 bit integer,
> so switch to using a phys_addr_t to hold them, to avoid
> silently dropping the top 32 bits of the size. Similarly, use
> phys_addr_t in early_mem() so that mem=size at start command line
> options specifying more than 4GB behave sensibly.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Changes v1->v2:
>  * fixed spacing round '-'
>  * made early_mem() handle large sizes too

Acked-by: Will Deacon <will.deacon@arm.com>

Please can you put this into the patch system?

Will
