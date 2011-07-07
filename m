From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 7 Jul 2011 02:25:23 -0600 (MDT)
Subject: [PATCH v3 03/13] OMAP4: hwmod: Replace CLKCTRL absolute address
	with offset macros
In-Reply-To: <1309554558-19819-4-git-send-email-b-cousson@ti.com>
References: <1309554558-19819-1-git-send-email-b-cousson@ti.com>
	<1309554558-19819-4-git-send-email-b-cousson@ti.com>
Message-ID: <alpine.DEB.2.00.1107070223340.30028@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> The CLKCTRL register was accessed using an absolute address.
> The usage of hardcoded macros to calculate virtual address from physical
> one should be avoided as much as possible.
> The usage of a offset will allow future improvement like migration from
> the current architecture code toward a module driver.
> 
> Update cm_xxx accessor, move definition to the proper header file and
> update copyrights.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

This patch was updated to use '_cminst_' in the function names that are in 
the cminst44xx.c file, rather than '_cm_', to preserve consistency with 
the rest of the file.  Updated patch below.


- Paul
