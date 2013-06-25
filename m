From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 25 Jun 2013 08:47:59 +0100
Subject: [PATCH] ARM: mm: Remove do_sect_fault from LPAE code
In-Reply-To: <201306242258.29470.arnd@arndb.de>
References: <1372067284-13389-1-git-send-email-steve.capper@linaro.org>
 <201306242258.29470.arnd@arndb.de>
Message-ID: <20130625074758.GA23259@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 10:58:29PM +0200, Arnd Bergmann wrote:
> On Monday 24 June 2013, Steve Capper wrote:
> > For LPAE, do_sect_fault used to be invoked as the second level access
> > flag handler. When transparent huge pages were introduced for LPAE,
> > do_page_fault was used instead.
> > 
> > Unfortunately, do_sect_fault remains defined but not used for LPAE code
> > resulting in a compile warning.
> > 
> > This patch surrounds do_sect_fault with #ifndef CONFIG_ARM_LPAE to fix
> > this warning.
> > 
> > Signed-off-by: Steve Capper <steve.capper@linaro.org>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd,
This is in Russell's system as 7775/1.

Cheers,
-- 
Steve
