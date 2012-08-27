From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 27 Aug 2012 10:19:06 -0700
Subject: [PATCH] spi/s3c64xx: Drop extra calls to spi_master_get in
 suspend/remove functions
In-Reply-To: <1345173265-1721-1-git-send-email-linux@roeck-us.net>
References: <1345173265-1721-1-git-send-email-linux@roeck-us.net>
Message-ID: <20120827171904.GP4339@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 08:14:25PM -0700, Guenter Roeck wrote:
> Suspend and resume functions call spi_master_get() without matching
> spi_master_put(). The extra references are unnecessary and cause subsequent
> module unload attempts to fail. Drop the calls.

Applied, thanks.
