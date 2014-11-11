From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Tue, 11 Nov 2014 15:51:14 +0100
Subject: [PATCH] arm64: dts: create an include directory for DT bindings
In-Reply-To: <1415712108-11352-1-git-send-email-bintian.wang@huawei.com>
References: <1415712108-11352-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <54622262.2010200@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 11.11.2014 um 14:21 schrieb Bintian Wang:
> Some header files may be used by both DT files and kernel, and we
> usually put them under <include/dt-bindings/>, and also include them
> in DT files just like:
>     #include <dt-bindings/xxx/xxx.h>
> for exaple, some clock header files.
> 
> On arm64 platform, the compiler will report an error and terminate
> when compiling DT files:
>     dt-bindings/xxx/xxx.h: No such file or directory
> 
> In order to fix the compile error, create an include directory and symlink
> dt-bindings from there to the actual location of include/dt-bindings/:
> 
> arch/arm64/boot/dts/include/dt-bindings -> ../../../../../include/dt-bindings
> 
> Signed-off-by: Bintian Wang <bintian.wang@huawei.com>
> ---
>  arch/arm64/boot/dts/include/dt-bindings | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 120000 arch/arm64/boot/dts/include/dt-bindings
> 
> diff --git a/arch/arm64/boot/dts/include/dt-bindings b/arch/arm64/boot/dts/include/dt-bindings
> new file mode 120000
> index 0000000..08c00e4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/include/dt-bindings
> @@ -0,0 +1 @@
> +../../../../../include/dt-bindings
> \ No newline at end of file

Such a patch was already on the list for the Juno board.

Regards,
Andreas

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg
