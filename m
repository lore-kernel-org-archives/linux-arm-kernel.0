From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 4 Jan 2018 07:39:39 -0800
Subject: [PATCH 02/11] arm64: Kconfig: Reword UNMAP_KERNEL_AT_EL0 kconfig
 entry
In-Reply-To: <1515078515-13723-3-git-send-email-will.deacon@arm.com>
References: <1515078515-13723-1-git-send-email-will.deacon@arm.com>
 <1515078515-13723-3-git-send-email-will.deacon@arm.com>
Message-ID: <20180104153939.GA3818@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 04, 2018 at 03:08:26PM +0000, Will Deacon wrote:
> Although CONFIG_UNMAP_KERNEL_AT_EL0 does make KASLR more robust, it's
> actually more useful as a mitigation against speculation attacks that
> can leak arbitrary kernel data to userspace through speculation.
> 
> Reword the Kconfig help message to reflect this, and make the option
> depend on EXPERT so that it is on by default for the majority of users.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Why is this not reusing the PAGE_TABLE_ISOLATION setting in
security/Kconfig ?
