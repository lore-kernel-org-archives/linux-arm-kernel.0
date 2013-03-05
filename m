From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 05 Mar 2013 08:13:06 -0800
Subject: [PATCH v3 -next 5/5] Kconfig: Make x86 and arm kernels default to
 the LZ4-compressed
In-Reply-To: <1362484056-9778-6-git-send-email-kyungsik.lee@lge.com>
References: <1362484056-9778-1-git-send-email-kyungsik.lee@lge.com>
 <1362484056-9778-6-git-send-email-kyungsik.lee@lge.com>
Message-ID: <951ecce5-9669-4d1e-97db-1d1946e83eb4@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm ok with this only if the patch is clearly marked LINUS DO NOT MERGE.

Kyungsik Lee <kyungsik.lee@lge.com> wrote:

>This patch makes x86 and arm kernels default to the LZ4-compressed
>to test new LZ4 code in the linux-next. This is requested by
>Andrew Morton.
>
>Signed-off-by: Kyungsik Lee <kyungsik.lee@lge.com>
>---
> init/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/init/Kconfig b/init/Kconfig
>index fc8eb1f..de3cb00 100644
>--- a/init/Kconfig
>+++ b/init/Kconfig
>@@ -138,7 +138,7 @@ config HAVE_KERNEL_LZ4
> 
> choice
> 	prompt "Kernel compression mode"
>-	default KERNEL_GZIP
>+	default KERNEL_LZ4
>	depends on HAVE_KERNEL_GZIP || HAVE_KERNEL_BZIP2 || HAVE_KERNEL_LZMA
>|| HAVE_KERNEL_XZ || HAVE_KERNEL_LZO || HAVE_KERNEL_LZ4
> 	help
> 	  The linux kernel is a kind of self-extracting executable.

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.
