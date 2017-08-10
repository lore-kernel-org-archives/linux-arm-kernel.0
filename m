From: labbott@redhat.com (Laura Abbott)
Date: Thu, 10 Aug 2017 13:13:22 -0700
Subject: New assembler warnings with binutils 2.29
Message-ID: <d101c48b-c47b-be60-4b40-de4f845e4965@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fedora rawhide recently upgraded to binutils 2.29 and this seems
to produce new warnings:

./arch/arm64/include/asm/assembler.h: Assembler messages:
./arch/arm64/include/asm/assembler.h:125: Warning: ignoring attempt to redefine built-in register 'lr'

This is

/*
 * Register aliases.
 */
lr      .req    x30             // link register

https://kojipkgs.fedoraproject.org//packages/kernel/4.13.0/0.rc2.git2.1.fc27/data/logs/aarch64/build.log
has an example log. As far as I can tell this doesn't affect anything at runtime.

Any ideas?

Thanks,
Laura
