From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Wed, 26 Aug 2015 19:15:03 +0300
Subject: [PATCH 0/4] KASAN/ARM64 EFI fixes
Message-ID: <1440605707-8325-1-git-send-email-ryabinin.a.a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/2015 08:23 PM, Will Deacon wrote:
> I tried this out under EFI and it dies horribly in the stub code because
> we're missing at least one KASAN_SANITIZE_ Makefile entry.
> 
> So I think this needs longer to stew before hitting mainline. By all means
> get the x86 dependencies in for 4.3, but the arm64 port can probably use
> another cycle to iron out the bugs.
> 
> Cheers,
> 
> Will
> 

These series fixes boot crash with KASAN under EFI.
I'm sending it separetly for easier review.
We have one more small x86 dependcy in the first patch.
Patches 2-4 I'm going to squash into v6 'arm64: add KASAN support' patch.


Andrey Ryabinin (4):
  x86, efi, kasan: #undef memset/memcpy/memmove per arch.
  efi/runtime-wrappers, kasan: don't sanitize runtime wrappers.
  arm64/efi-stub, kasan: don't instrument efi-stub.
  libfdt, kasan: don't instrument libfdt.

 arch/arm64/kernel/Makefile             | 2 ++
 arch/x86/include/asm/efi.h             | 8 ++++++++
 drivers/firmware/efi/Makefile          | 8 ++++++++
 drivers/firmware/efi/libstub/efistub.h | 4 ----
 lib/Makefile                           | 3 ++-
 5 files changed, 20 insertions(+), 5 deletions(-)

--
2.4.6
