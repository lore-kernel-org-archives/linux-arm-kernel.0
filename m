From: matt@console-pimps.org (Matt Fleming)
Date: Wed, 6 Aug 2014 15:18:14 +0100
Subject: [PATCH 1/2] UEFI arm64: add noefi boot param
In-Reply-To: <CAKv+Gu8ey1iKu-_wS6yYaEXQaQMDXa+PF5Kiw+edA9a_OE1EAw@mail.gmail.com>
References: <20140806083825.GA31711@dhcp-16-198.nay.redhat.com>
 <20140806130623.GI4179@bivouac.eciton.net>
 <20140806132021.GB15082@console-pimps.org>
 <20140806132941.GJ4179@bivouac.eciton.net>
 <20140806140155.GC15082@console-pimps.org>
 <CAKv+Gu8ey1iKu-_wS6yYaEXQaQMDXa+PF5Kiw+edA9a_OE1EAw@mail.gmail.com>
Message-ID: <20140806141814.GD15082@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 06 Aug, at 04:10:45PM, Ard Biesheuvel wrote:
> 
> Shouldn't we clear the bit here if we failed to enable runtime
> services for some reason? Other code may test the bit assuming that it
> signifies that runtime services have been enabled successfully, while
> this patch changes it to mean that we /intended/ to enable them, which
> is not quite the same thing.

Yep, good catch. We need to do something similar for efi_runtime_init()
on x86 too.

-- 
Matt Fleming, Intel Open Source Technology Center
