From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Jan 2013 13:52:05 +0200
Subject: [PATCH v7 00/22] OMAP USB Host cleanup
In-Reply-To: <1358422231-24736-1-git-send-email-rogerq@ti.com>
References: <1358422231-24736-1-git-send-email-rogerq@ti.com>
Message-ID: <20130117115205.GJ18978@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 17, 2013 at 01:30:09PM +0200, Roger Quadros wrote:
> Hi,
> 
> This patchset addresses the following
> 
> - Consolidate USB Host platform data.
> - Avoid addressing clocks one by one by name and use a for loop + bunch
>   of cleanups.
> - Get number of channels/ports dynamically either from revision register
>   or from platform data. Avoids getting clocks that are not present.
> - Add OMAP5 and HSIC mode (Not tested).
> 
> v7:
> - Updated patch 4 to not hold a spinlock when using clk_get().
> - Updated patches 3 and 11 to return -EADDRNOTAVAIL on failure of
>   demv_request_and_ioremap().
> 
> v6:
> - Added USB Host platform data consolidation patch as the first patch.
>   based on request from Tony.
> - Rebased on v3.8-rc3.
> 
> v5:
> - Rebased on top of todays arm-soc/for-next.
> - Removed the clock merging patch from the list.
> - Updated patches 14, 19 and 20 to accomodate the above change.
> - Added patch 22 to fix a build warning.
> 
> v4:
> - Added appropriate maintainers in to/cc.
> - minor print message fix in patch 23 to maintain consistency.
> 
> v3:
> - Rebased on arm-soc/for-next commit f979306c4d38d213c6977aaf3b1115e8ded71e3a.
> - Rearranged patch that get rids of cpu_is_omap..() macros.
> - Coding style fixes.
> 
> v2:
> - Clocks are allocated dynamically based on number of ports available
>   on the platform.
> - Reduced console spam if non critical clocks are not found on the platform.
> - Get rid of cpu_is_.. macros from USB host driver.
> 
> cheers,
> -roger
> 
> The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:
> 
>   Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)
> 
> are available in the git repository at:
>   git at github.com:rogerq/linux.git linux-usbhost12-part

not everybody has account on github, you need to set url to something
non-authenticated and pushurl to the ssh url.

anyway, after fixing a few comments on the patches below, I guess this
is all ready for mailine, you can add to the entire series:

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130117/3899f155/attachment-0001.sig>
