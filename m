From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 9 Jan 2018 09:17:00 -0800
Subject: [PATCH v3 02/13] arm64: Kconfig: Reword UNMAP_KERNEL_AT_EL0
 kconfig entry
In-Reply-To: <1515432758-26440-3-git-send-email-will.deacon@arm.com>
References: <1515432758-26440-1-git-send-email-will.deacon@arm.com>
 <1515432758-26440-3-git-send-email-will.deacon@arm.com>
Message-ID: <20180109171700.GA18100@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 05:32:27PM +0000, Will Deacon wrote:
> Although CONFIG_UNMAP_KERNEL_AT_EL0 does make KASLR more robust, it's
> actually more useful as a mitigation against speculation attacks that
> can leak arbitrary kernel data to userspace through speculation.
> 
> Reword the Kconfig help message to reflect this, and make the option
> depend on EXPERT so that it is on by default for the majority of users.

I still haven't heard an anwer on why this isn't using
CONFIG_PAGE_TABLE_ISOLATION but instead reinvents its own symbol.
