From: olof@lixom.net (Olof Johansson)
Date: Wed, 16 May 2012 21:53:51 -0700
Subject: [PATCH] ARM: PRIMA2: fix irq domain size and IRQ mask of internal
 interrupt controller
In-Reply-To: <1337225335-14133-1-git-send-email-Barry.Song@csr.com>
References: <1337225335-14133-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CAOesGMhXw5H2o51prDJxSm78H-gwROjkQH9_P0HRVRqLJF5MkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 8:28 PM, Barry Song <Barry.Song@csr.com> wrote:
> From: Barry Song <Baohua.Song@csr.com>
>
> the old codes will cause 3.4 kernel warning as irq domain size is wrong:
> ------------[ cut here ]------------
> WARNING: at kernel/irq/irqdomain.c:74 irq_domain_legacy_revmap+0x24/0x48()
> Modules linked in:
> [<c0013f50>] (unwind_backtrace+0x0/0xf8) from [<c001e7d8>] (warn_slowpath_common+0x54/0x64)
> [<c001e7d8>] (warn_slowpath_common+0x54/0x64) from [<c001e804>] (warn_slowpath_null+0x1c/0x24)
> [<c001e804>] (warn_slowpath_null+0x1c/0x24) from [<c005c3c4>] (irq_domain_legacy_revmap+0x24/0x48)
> [<c005c3c4>] (irq_domain_legacy_revmap+0x24/0x48) from [<c005c704>] (irq_create_mapping+0x20/0x120)
> [<c005c704>] (irq_create_mapping+0x20/0x120) from [<c005c880>] (irq_create_of_mapping+0x7c/0xf0)
> [<c005c880>] (irq_create_of_mapping+0x7c/0xf0) from [<c01a6c48>] (irq_of_parse_and_map+0x2c/0x34)
> [<c01a6c48>] (irq_of_parse_and_map+0x2c/0x34) from [<c01a6c68>] (of_irq_to_resource+0x18/0x74)
> [<c01a6c68>] (of_irq_to_resource+0x18/0x74) from [<c01a6ce8>] (of_irq_count+0x24/0x34)
> [<c01a6ce8>] (of_irq_count+0x24/0x34) from [<c01a7220>] (of_device_alloc+0x58/0x158)
> [<c01a7220>] (of_device_alloc+0x58/0x158) from [<c01a735c>] (of_platform_device_create_pdata+0x3c/0x80)
> [<c01a735c>] (of_platform_device_create_pdata+0x3c/0x80) from [<c01a7468>] (of_platform_bus_create+0xc8/0x190)
> [<c01a7468>] (of_platform_bus_create+0xc8/0x190) from [<c01a74cc>] (of_platform_bus_create+0x12c/0x190)
> ---[ end trace 1b75b31a2719ed32 ]---
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>


Thanks, applied to fixes.



-Olof
