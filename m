From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Nov 2016 14:25:29 +0000
Subject: [PATCH] arm64: mm: Fix memmap to be initialized for the entire
 section
In-Reply-To: <20161109195132.GZ22012@rric.localdomain>
References: <1475747527-32387-1-git-send-email-rrichter@cavium.com>
 <CAKv+Gu-oYzSn_eeqaX3QVFeQjBGkaX-Wh7+oPcQFcXv7J6GOFQ@mail.gmail.com>
 <20161006161114.GH22012@rric.localdomain>
 <20161017185801.GT25086@rric.localdomain>
 <20161027160136.GD24290@arm.com>
 <20161028091905.GM22012@rric.localdomain>
 <20161107210514.GP20591@arm.com>
 <20161109195132.GZ22012@rric.localdomain>
Message-ID: <20161117142528.GJ22855@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 08:51:32PM +0100, Robert Richter wrote:
> Thus, I don't see where my patch breaks code. Even acpi_os_ioremap()
> keeps the same behaviour as before since it still uses memblock_is_
> memory(). Could you more describe your concerns why do you think this
> patch breaks the kernel and moves the problem somewhere else? I
> believe it fixes the problem at all.

acpi_os_ioremap always ends up in __ioremap_caller, regardless of
memblock_is_memory(). __ioremap_caller then fails if pfn_valid is true.

Will
