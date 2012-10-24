From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Oct 2012 13:21:26 +0000
Subject: [PATCH 1/1] mmc: Standardise capability type
In-Reply-To: <1351084664-30526-1-git-send-email-lee.jones@linaro.org>
References: <1351084664-30526-1-git-send-email-lee.jones@linaro.org>
Message-ID: <201210241321.26878.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 October 2012, Lee Jones wrote:
> 
> There are discrepancies with regards to how MMC capabilities
> are carried throughout the subsystem. Let's standardise them
> to elevate any confusion.
> 
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Why make it "unsigned long" then? I think that adds to the
confusion because it's sometimes 32 bits and sometimes 64 bits,
depending on the CPU. Since it's a bitmask, I would suggest
using u32 to make the size explicit.

	Arnd
