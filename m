From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 17 Aug 2017 22:12:45 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Add
 CONFIG_FW_LOADER_USER_HELPER_FALLBACK
In-Reply-To: <20170817140424.4614-1-gary.bisson@boundarydevices.com>
References: <20170817140424.4614-1-gary.bisson@boundarydevices.com>
Message-ID: <20170817141243.GG7608@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 04:04:24PM +0200, Gary Bisson wrote:
> Allows to load firmware files which aren't built inside the kernel.
> 
> Especially useful for CODA firmware (vpu_fw_imx6q.bin) which is usually
> located in the rootfs.
> 
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> ---
> Hi Shawn,
> 
> I'm not sure if this patch is acceptable since I've noticed that no
> configuration currently has that option enabled (why?).
> 
> As mentioned in the commit, I had to enable that in order to have CODA
> load the VPU firmware properly.
> 
> Another option would be to make the CODA driver a module...
> 
> Let me know your thoughts.

@Philipp, do you have any comments on this?

>From reading of the option help text, I feel the option is not
recommended?

config FW_LOADER_USER_HELPER_FALLBACK

This option enables / disables the invocation of user-helper
(e.g. udev) for loading firmware files as a fallback after the
direct file loading in kernel fails.  The user-mode helper is
no longer required unless you have a special firmware file that
resides in a non-standard path. Moreover, the udev support has
been deprecated upstream.

Shawn
