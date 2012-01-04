From: specter118@gmail.com (Hu Ruihuan)
Date: Wed, 4 Jan 2012 22:05:55 +0800
Subject: the bug of free_memmap
Message-ID: <CAN-V0CA+B9k-EQ72mafN6w8zhBGsa2EXy1EropaHtAaZRMSK9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, everyone,
    I have fount a bug in free_memmap function. When using sparsemem,
and just a memory section is in a hole, the start_pfn parameter of
free_memmap will be the last page of the section forward. Then the
start_pg will be the address of the last page of the section forward
plus the size of struct page, not the right one.
