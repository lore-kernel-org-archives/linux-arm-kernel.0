From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Sat,  9 Feb 2013 23:15:07 +0000
Subject: v3.8-rc issues with big endian
Message-ID: <1360451709-19740-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whilst debugging with big endian ARM on v3.8-rc I came across a problem
with the new ASID code (commit b5466f8728527a05a493cc4abe9e6f034a1bbaab)
which is causing issues with user-land failing to work.

Since the new ASID code is using 64-bit accesses, the ASID ID is now
being placed in context->id + 4, which means that the assembly mm code
no-longer works.

I also noticed and fixed a couple of places where the new mmid macro was
not being used, so fixed those too.

Tested on a highbank system.

 [PATCH 1/2] ARM: mm: replace direct access to mm->context.id with
 [PATCH 2/2] ARM: mm: mm->context.id fix for big-endian
