From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 8 Jan 2013 20:38:14 +0530
Subject: [RFC v2 08/18] ARM: OMAP2+: AM33XX: hwmod: Fixup cpgmac0 hwmod
 entry
In-Reply-To: <1356959231-17335-9-git-send-email-vaibhav.bedia@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-9-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <50EC365E.70202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
> The current HWMOD code expects the memory region with
> the IP's SYSCONFIG register to be marked with ADDR_TYPE_RT
> flag.
>
> CPGMAC0 hwmod entry specifies two memory regions and marks
> both with the flag ADDR_TYPE_RT although only the 2nd region
> has the SYSCONFIG register. This leads to the HWMOD code
> accessing the wrong memory address for idle and standby
> operations. Fix this by removing the ADDR_TYPE_RT flag from
> the 1st memory region in CPGMAC0 hwmod entry.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
Seems correct to me though Benoit, Paul can
may have comment.

Regards
Santosh
