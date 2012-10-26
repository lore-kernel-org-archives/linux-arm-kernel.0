From: marex@denx.de (Marek Vasut)
Date: Fri, 26 Oct 2012 12:01:58 +0200
Subject: [PATCH V2] ARM: mx28: Skip OCOTP FEC MAC setup if in DT
In-Reply-To: <1348572738-9743-1-git-send-email-marex@denx.de>
References: <1348572738-9743-1-git-send-email-marex@denx.de>
Message-ID: <201210261201.58778.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> Currently, the kernel unconditionally adds "local-mac-address" and
> "mac-address" properties under both FEC ethernet DT nodes in case
> the update_fec_mac_prop() function is called. These properties are
> loaded with MAC address compiled from vendors OUI and a per-device
> NIC saved in OCOTP storage.
> 
> Some more advanced bootloaders do augment the DT passed to the kernel
> by these properties already. In such case, it is wrong for kernel to
> override these values.
> 
> Adjust the FEC MAC address loading so that in case the DT properties
> are already present in the DT passed from the bootloader, skip the
> loading from OCOTP altogether. If the DT properties are not present,
> load them from OCOTP.
> 
> Note that the later case will lead to zeroed out MAC address if OCOTP
> is not programmed. This will lead to FEC not working at all.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
[...]

Can we apply this for 3.7? I believe it is harmless and beneficial for some 
parties at least.

Best regards,
Marek Vasut
