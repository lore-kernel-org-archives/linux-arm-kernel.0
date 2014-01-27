From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 27 Jan 2014 12:25:37 +0000
Subject: [PATCH] arm64: add DSB after icache flush in __flush_icache_all()
In-Reply-To: <1390823984-23046-1-git-send-email-vkale@apm.com>
References: <1390823984-23046-1-git-send-email-vkale@apm.com>
Message-ID: <20140127122536.GE32608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 11:59:44AM +0000, Vinayak Kale wrote:
> Add DSB after icache flush operation.
> 
> Signed-off-by: Vinayak Kale <vkale@apm.com>

I think we should also mention that this function is used for user
addresses and an ISB is not required because of an exception return
before executing user instructions.

-- 
Catalin
