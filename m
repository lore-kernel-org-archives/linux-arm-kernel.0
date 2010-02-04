From: e.robertson.svg@gmail.com (E Robertson)
Date: Wed, 3 Feb 2010 21:17:29 -0600
Subject: copy_to_user limits inquiry
Message-ID: <3972542e1002031917y5929adb8k9f1043ef3dcd0d1c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I allocate two 16 page buffers (64K) for a DMA transfer. These were
allocated using dma_alloc_coherent and I had not problems with this
until I start approaching the buffer limit.
The buffer transfers to userspace (copy_to_user) worked flawlessly
(well it has for months anyway) until my transfer sizes got pretty
close to the last two 4096 pages and it's fairly consistent.
Since this happens on two different 2.6 kernel versions and the DMA
data transfer driver is the same, it seems the problem lies somewhere
during the transfer from kernel to user.
Are their any size restrictions on using the copy_to_user? Perhaps
page restrictions?
Thanks.
