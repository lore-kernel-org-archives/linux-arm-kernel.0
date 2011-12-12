From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Dec 2011 16:48:51 +0000
Subject: [Linaro-mm-sig] [RFC v2 1/2] dma-buf: Introduce dma buffer
 sharing mechanism
In-Reply-To: <CAKMK7uH+4uSYYjBLcvfhVC+iwGUZ09Z4p64fNBzh196aG+hqgg@mail.gmail.com>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <20111209142405.6f371be6@pyramind.ukuu.org.uk>
 <CAKMK7uH+4uSYYjBLcvfhVC+iwGUZ09Z4p64fNBzh196aG+hqgg@mail.gmail.com>
Message-ID: <201112121648.52126.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 10 December 2011, Daniel Vetter wrote:
> If userspace (through some driver calls)
> tries to do stupid things, it'll just get garbage. See
> Message-ID: <CAKMK7uHeXYn-v_8cmpLNWsFY14KtmuRZy8YRKR5Xst2-2WdFSQ@mail.gmail.com>
> for my reasons why it think this is the right way to go forward. So in
> essence I'm really interested in the reasons why you want the kernel
> to enforce this (or I'm completely missing what's the contentious
> issue here).

This has nothing to do with user space mappings. Whatever user space does,
you get garbage if you don't invalidate cache lines that were introduced
through speculative prefetching before you access cache lines that were
DMA'd from a device.

	Arnd
