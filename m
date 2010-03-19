From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Mar 2010 12:32:01 +0000
Subject: [PATCH] ARM: sort the memory layout report by address
In-Reply-To: <06dbc8f0e15bf48be70cd43ee6a5ab78b82711a8.1268734689.git.baruch@tkos.co.il>
References: <06dbc8f0e15bf48be70cd43ee6a5ab78b82711a8.1268734689.git.baruch@tkos.co.il>
Message-ID: <20100319123201.GB21280@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 16, 2010 at 12:19:07PM +0200, Baruch Siach wrote:
> Put the pkmap and the modules lines at the end of the list since they reside
> lower than the kernel text in virtual memory address space.

This still doesn't result in the list being sorted - .init is at a lower
address than .text, which is in turn at a lower address than .data.

Even more unfortunate is that even if you did get it correct for non-XIP
configurations, it wouldn't be correct for XIP configurations.
