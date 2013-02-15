From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 15 Feb 2013 12:54:38 +0100
Subject: [PATCH 10/11] ARM: s3c: i2c: add platform_device forward
 declaration
In-Reply-To: <1360849767-1463135-11-git-send-email-arnd@arndb.de>
References: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
 <1360849767-1463135-11-git-send-email-arnd@arndb.de>
Message-ID: <20130215115438.GA21335@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 02:49:26PM +0100, Arnd Bergmann wrote:
> A recent cleanup to the mach-osiris.c file is causing build errors
> because the i2c-s3c2410.h header file is included before we see
> the definition for platform_device. The fix is to make the header file
> more robust against inclusion from other places. While this should
> normally go through the i2c tree, the bug only exists in arm-soc
> at the moment, so it's easier to fix it there before it goes upstream.
> 
> Without this patch, building s3c2410_defconfig results in:
> 
> arch/arm/mach-s3c24xx/mach-osiris.c:34:0:
> include/linux/platform_data/i2c-s3c2410.h:37:26: warning: 'struct platform_device' declared inside parameter list [enabled by default]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Fine with me:

Acked-by: Wolfram Sang <wsa@the-dreams.de>
