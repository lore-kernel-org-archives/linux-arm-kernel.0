From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Mar 2014 06:53:39 +0000
Subject: [PATCH] ARM64: Kernel managed pages are only flushed
In-Reply-To: <1394018446-16738-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1394018446-16738-1-git-send-email-Bharat.Bhushan@freescale.com>
Message-ID: <20140306065339.GA2975@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 04:50:46PM +0530, Bharat Bhushan wrote:
> Kernel can only access pages which maps to managed memory.
> So flush only valid kernel pages.
> 
> I observed kernel crash direct assigning a device using VFIO
> and found that it was caused because of accessing invalid page

I don't get this. Could you please share some kernel crash message to
see the backtrace? The __sync_icache_dcache() function is called from
set_pte_at() if the pte is valid, user and exec. If these are correct,
why does it crash? Actually, does the cache maintenance crash or
page_mapping()?

-- 
Catalin
