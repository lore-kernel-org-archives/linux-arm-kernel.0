From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Jan 2013 16:00:46 +0000
Subject: [PATCH 1/2] ARM: use Kconfig to select uncompress.h
In-Reply-To: <1358436119-30808-2-git-send-email-shawn.guo@linaro.org>
References: <1358436119-30808-1-git-send-email-shawn.guo@linaro.org>
 <1358436119-30808-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <201301171600.46675.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 January 2013, Shawn Guo wrote:
> Spam Status: Spamassassin 0% probability of being spam.
> 
> Full report:
> No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW, UNPARSEABLE_RELAY autolearn=unavailable version=3.3.1  
> Following the approach handling DEBUG_LL inclusion, the patch creates
> a Kconfig symbol CONFIG_UNCOMPRESS_INCLUDE for choosing the correct
> uncompress header.  For traditional build, mach/uncompress.h will be
> included in arch/arm/boot/compressed/misc.c.  For multiplatform build,
> debug/uncompress.h which contains a suite of empty functions will be
> used.  In this way, a platform with particular uncompress.h
> implementation could choose its own uncompress.h with this Kconfig
> option.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Nice trick!

Acked-by: Arnd Bergmann <arnd@arndb.de>
