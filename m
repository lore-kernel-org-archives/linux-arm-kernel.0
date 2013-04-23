From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 23 Apr 2013 11:46:46 -0500
Subject: [PATCH 15/21] staging: comedi/dawboard2000: use mdelay for
 large delays
In-Reply-To: <1366734653-488286-16-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
 <1366734653-488286-16-git-send-email-arnd@arndb.de>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0021D422D5F61@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, April 23, 2013 9:31 AM, Arnd Bergmann wrote:
> Subject: [PATCH 15/21] staging: comedi/dawboard2000: use mdelay for large delays

Nit.. Typo in subject.

> On ARM, it is not legal to pass values larger than 2ms into udelay(),
> and mdelay() must be used instead, to avoid this build error:
>
> ERROR: "__bad_udelay" [drivers/staging/comedi/drivers/daqboard2000.ko]
> undefined!
>
> On a related note, any use of mdelay() or large udelay() numbers should
> be carefully reviewed, and replaced with msleep() or a different
> implementation that does not rely on delaying the work.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ian Abbott <abbotti@mev.co.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Thanks,
Hartley
