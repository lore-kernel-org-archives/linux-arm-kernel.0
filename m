From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Jun 2013 22:58:29 +0200
Subject: [PATCH] ARM: mm: Remove do_sect_fault from LPAE code
In-Reply-To: <1372067284-13389-1-git-send-email-steve.capper@linaro.org>
References: <1372067284-13389-1-git-send-email-steve.capper@linaro.org>
Message-ID: <201306242258.29470.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 June 2013, Steve Capper wrote:
> For LPAE, do_sect_fault used to be invoked as the second level access
> flag handler. When transparent huge pages were introduced for LPAE,
> do_page_fault was used instead.
> 
> Unfortunately, do_sect_fault remains defined but not used for LPAE code
> resulting in a compile warning.
> 
> This patch surrounds do_sect_fault with #ifndef CONFIG_ARM_LPAE to fix
> this warning.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
