From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jul 2018 18:36:15 +0100
Subject: [PATCHv5 4/4] arm64: Add build salt to the vDSO
In-Reply-To: <20180703233430.14416-5-labbott@redhat.com>
References: <20180703233430.14416-1-labbott@redhat.com>
 <20180703233430.14416-5-labbott@redhat.com>
Message-ID: <20180704173615.GC9668@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2018 at 04:34:30PM -0700, Laura Abbott wrote:
> 
> The vDSO needs to have a unique build id in a similar manner
> to the kernel and modules. Use the build salt macro.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v5: I was previously focused on x86 only but since powerpc gave a patch,
> I figured I would do arm64 since the changes were also fairly simple.
> ---
>  arch/arm64/kernel/vdso/note.S | 3 +++
>  1 file changed, 3 insertions(+)

If you drop the trailing semicolon, then:

Acked-by: Will Deacon <will.deacon@arm.com>

Will

> diff --git a/arch/arm64/kernel/vdso/note.S b/arch/arm64/kernel/vdso/note.S
> index b82c85e5d972..2c429dfd3f45 100644
> --- a/arch/arm64/kernel/vdso/note.S
> +++ b/arch/arm64/kernel/vdso/note.S
> @@ -22,7 +22,10 @@
>  #include <linux/uts.h>
>  #include <linux/version.h>
>  #include <linux/elfnote.h>
> +#include <linux/build-salt.h>
>  
>  ELFNOTE_START(Linux, 0, "a")
>  	.long LINUX_VERSION_CODE
>  ELFNOTE_END
> +
> +BUILD_SALT;
> -- 
> 2.17.1
> 
