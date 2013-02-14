From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 14 Feb 2013 20:41:31 -0200
Subject: [PATCH 6/9] drm/pci: move drm_pcie_get_speed_cap_mask inside
 #ifdef CONFIG_PCI
In-Reply-To: <1360880818-4071454-7-git-send-email-arnd@arndb.de>
References: <1360880818-4071454-1-git-send-email-arnd@arndb.de>
 <1360880818-4071454-7-git-send-email-arnd@arndb.de>
Message-ID: <CAOMZO5AbTC+82KKTqWXeseahsasx2q=q-4k9u14xyBYhgm2gdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 8:26 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> commit dd66cc2e1  "drm/pci: Use PCI Express Capability accessors"
> introduced the use of the pcie_capability_read_dword function
> in the drm_pci code, which is only defined when PCI is enabled.
> While most of the file is already hidden away behind an #ifdef
> CONFIG_PCI, this function is not, and that now causes a link
> error in the ARM imx_v6_v7_defconfig configuration.
>
> Moving the function into the #ifdef section makes this work
> again on IMX, which does not have PCI support, and should
> have no impact on platforms that do.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Dave Airlie <airlied@redhat.com>

Bjorn has already sent a fix for this problem:
http://www.spinics.net/lists/arm-kernel/msg224425.html
