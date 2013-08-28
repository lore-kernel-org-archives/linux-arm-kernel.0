From: anton@enomsg.org (Anton Vorontsov)
Date: Tue, 27 Aug 2013 18:35:38 -0700
Subject: [PATCH] power/reset: Make vexpress driver depend on required
 infrastructure
In-Reply-To: <1376580952-21677-1-git-send-email-pawel.moll@arm.com>
References: <20130815114401.GD23006@n2100.arm.linux.org.uk>
 <1376580952-21677-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20130828013538.GF10506@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 04:35:52PM +0100, Pawel Moll wrote:
> ARM Versatile Express reset driver requires platform-specific
> config infrastructure to be present in the kernel. When
> VEXPRESS_CONFIG is not selected, the build will fail like this:
> 
> drivers/built-in.o: In function `vexpress_reset_do.clone.0':
> iio-trig-interrupt.c:(.text+0x1aff38): undefined reference to `__vexpress_config_func_get'
> iio-trig-interrupt.c:(.text+0x1aff4c): undefined reference to `vexpress_config_write'
> 
> Added required dependency to the Kconfig entry.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Applied, thanks!

Anton
