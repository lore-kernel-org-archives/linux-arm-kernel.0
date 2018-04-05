From: willy@infradead.org (Matthew Wilcox)
Date: Thu, 5 Apr 2018 04:23:57 -0700
Subject: [PATCH v7 1/5] mm: page_alloc: remain memblock_next_valid_pfn()
 on arm and arm64
In-Reply-To: <1522915478-5044-2-git-send-email-hejianet@gmail.com>
References: <1522915478-5044-1-git-send-email-hejianet@gmail.com>
 <1522915478-5044-2-git-send-email-hejianet@gmail.com>
Message-ID: <20180405112357.GA2647@bombadil.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2018 at 01:04:34AM -0700, Jia He wrote:
>  create mode 100644 include/linux/arm96_common.h

'arm96_common'?!  No.  Just no.

The right way to share common code is to create a header file (or use
an existing one), either in asm-generic or linux, with a #ifdef CONFIG_foo
block and then 'select foo' in the arm Kconfig files.  That allows this
common code to be shared, maybe with powerpc or x86 or ... in the future.
