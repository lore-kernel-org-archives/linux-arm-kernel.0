From: chanho61.park@samsung.com (Chanho Park)
Date: Tue, 23 Sep 2014 16:46:33 +0900
Subject: [PATCH v5 8/8] arm64: dts: add <dt-bindings/> symlink
In-Reply-To: <1411361228-18279-9-git-send-email-a.kesavan@samsung.com>
References: <1411361228-18279-1-git-send-email-a.kesavan@samsung.com>
 <1411361228-18279-9-git-send-email-a.kesavan@samsung.com>
Message-ID: <012f01cfd702$7ed15c30$7c741490$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Abhilash Kesavan
> Sent: Monday, September 22, 2014 1:47 PM
> To: linux-samsung-soc at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; devicetree at vger.kernel.org;
> catalin.marinas at arm.com
> Cc: naveenkrishna.ch at gmail.com; kesavan.abhilash at gmail.com;
> tomasz.figa at gmail.com
> Subject: [PATCH v5 8/8] arm64: dts: add <dt-bindings/> symlink
> 
> From: Pankaj Dubey <pankaj.dubey@samsung.com>
> 
> Add symlink to include/dt-bindings from arch/arm64/boot/dts/include/ to
> match the ones in ARM architectures so that preprocessed device
> tree files can include various useful constant definitions.
> 
> See commit c58299aa8754 ("kbuild: create an "include chroot" for DT
> bindings")
> merged in v3.10-rc1 for details.
> 
> CC: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Reviewed-by: Thomas Abraham <thomas.ab@samsung.com>
> Tested-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm64/boot/dts/include/dt-bindings | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 120000 arch/arm64/boot/dts/include/dt-bindings
> 
> diff --git a/arch/arm64/boot/dts/include/dt-bindings
> b/arch/arm64/boot/dts/include/dt-bindings
> new file mode 120000
> index 0000000..1e89bce
> --- /dev/null
> +++ b/arch/arm64/boot/dts/include/dt-bindings
> @@ -0,0 +1 @@
> +../../../../../include/dt-bindings/
> \ No newline at end of file
^
It generates incorrect symlink. Please remove last line like below:

diff --git a/arch/arm64/boot/dts/include/dt-bindings
b/arch/arm64/boot/dts/include/dt-bindings
new file mode 120000
index 0000000..499472b
--- /dev/null
+++ b/arch/arm64/boot/dts/include/dt-bindings
@@ -0,0 +1 @@
+../../../../../include/dt-bindings/
--

Best Regards,
Chanho Park
