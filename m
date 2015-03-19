From: robherring2@gmail.com (Rob Herring)
Date: Thu, 19 Mar 2015 08:23:29 -0500
Subject: [patch 2/7] dt: dtb version: document chosen/dtb-info node binding
In-Reply-To: <550A4382.4030209@gmail.com>
References: <550A42AC.8060104@gmail.com> <550A4382.4030209@gmail.com>
Message-ID: <CAL_Jsq+sPkZtreQ0sp8KXpkUVpFy=Yh9dr249u8uyoa8yksjmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 10:33 PM, Frank Rowand <frowand.list@gmail.com> wrote:
> From: Frank Rowand <frank.rowand@sonymobile.com>
>
> Add /chosen/dtb-node binding.

Why? Please write better commit messages.

>
> Signed-off-by: Frank Rowand <frank.rowand@sonymobile.com>
> ---
>  Documentation/devicetree/bindings/chosen.txt |   37 +++++++++++
>
> Index: b/Documentation/devicetree/bindings/chosen.txt
> ===================================================================
> --- a/Documentation/devicetree/bindings/chosen.txt
> +++ b/Documentation/devicetree/bindings/chosen.txt
> @@ -46,6 +46,43 @@ on PowerPC "stdout" if "stdout-path" is
>  should only use the "stdout-path" property.
>
>
> +dtb-info node
> +----------------
> +
> +Information that describes where the device tree blob (DTB) came from and the
> +environment it was created in.
> +
> +This node is normally created by including arch/arm/boot/dts/skeleton.dtsi,
> +which includes include/dt-bindings/version.dtsi.
> +
> +Properties:
> +
> +version
> +       The version of the DTB.  This is analagous to the linux kernel version.
> +
> +       This is a format free field intended for human consumption.  User space
> +       programs should not have any expections about this property.
> +
> +       The DTB number in this property is incremented each time a make that
> +       creates one or more DTBs is invoked.  If the make creates multiple
> +       DTBs then this number is only incremented once.
> +
> +       The DTB number is stored in file .version_dtb.
> +
> +version-linux
> +       The version of the linux kernel most recently built in the source
> +       control system that contains the source used to build the DTB.
> +
> +       The linux kernel version number is not incremented for a make that
> +       creates a DTB.
> +
> +dtb-path
> +       The build directory relative path of the DTB.
> +
> +dts-path
> +       The absolute path of the .dts file compiled to create the DTB.

So these become an ABI and we can never change the directory structure?

The problem with informational fields is someone, somewhere will rely
on them and then we are stuck with them. Look at /proc/cpuinfo.

Rob
