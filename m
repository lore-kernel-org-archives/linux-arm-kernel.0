From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Jun 2015 23:41:34 +0100
Subject: [PATCHv3 2/2] arm: use max_lowmem_limit in find_limit()
In-Reply-To: <1433962773-8402-3-git-send-email-orca.chen@gmail.com>
References: <1433962773-8402-1-git-send-email-orca.chen@gmail.com>
 <1433962773-8402-3-git-send-email-orca.chen@gmail.com>
Message-ID: <20150610224134.GS7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 11, 2015 at 02:59:33AM +0800, Min-Hua Chen wrote:
> In commit: 1c2f87c22566cd057bc8cde10c37ae9da1a1bb76, the max_low is
> set by memblock_get_current_limit(). However memblock.current_limit
> can be changed by memblock_set_current_limit() any point before
> find_limits().
> 
> It's better to use arm_lowmem_limit to be max_lowmem in two ways:
> First, arm_lowmem_limit cannot be changed by a public API. Second, the
> high_memory is set by arm_lowmem_limit and is a natural limit of
> low memory area in bootmem_init().
> 
> Signed-off-by: Min-Hua Chen <orca.chen@gmail.com>

NAK, this is a known build breaker.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
