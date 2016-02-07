From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 6 Feb 2016 22:03:54 -0800
Subject: [PATCH] staging: wilc1000: fix compilation without CONFIG_PM
In-Reply-To: <1454685729-3663377-1-git-send-email-arnd@arndb.de>
References: <1454685729-3663377-1-git-send-email-arnd@arndb.de>
Message-ID: <20160207060354.GA2714@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 05, 2016 at 04:21:50PM +0100, Arnd Bergmann wrote:
> After the addition of the wakeup code in wilc1000, it no longer
> builds when CONFIG_PM is disabled:
> 
> drivers/staging/wilc1000/wilc_wfi_cfgoperations.c: In function 'wilc_create_wiphy':
> drivers/staging/wilc1000/wilc_wfi_cfgoperations.c:2632:13: error: 'struct wiphy' has no member named 'wowlan'
>   wdev->wiphy->wowlan = &wowlan_support;
> 
> This marks the wowlan_support variable as __maybe_unused and hides
> the reference when CONFIG_PM is disabled to avoid the build error.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 73584a40d748 ("staging: wilc1000: add ops resuem/suspend/wakeup in cfg80211")
> ---
>  drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

A different patch was sent just before yours.  Actually 2 different
ones...

thanks,

greg k-h
