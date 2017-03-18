From: eric@anholt.net (Eric Anholt)
Date: Fri, 17 Mar 2017 17:07:17 -0700
Subject: [PATCH v4 5/7] arm64: set CONFIG_MMC_BCM2835=y in defconfig
In-Reply-To: <1488964751-22763-10-git-send-email-kraxel@redhat.com>
References: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
 <1488964751-22763-10-git-send-email-kraxel@redhat.com>
Message-ID: <874lyrjvm2.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gerd Hoffmann <kraxel@redhat.com> writes:

> We need to enable this controller so that we can switch the SD card's
> pinmux over to it by default, which will improve storage performance.
>
> Read access (dd with 64k blocks on rpi2):
>   CONFIG_MMC_SDHCI_IPROC: 11-12 MB/s
>   CONFIG_MMC_BCM2835:     19-20 MB/s
>
> Differences on write access are pretty much in the noise.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Now that the driver has been merged, I've merged the platform patches up
to this point.

Unfortunately, sending PRs to arm-soc that merge in branches from other
trees has failed in the past, so I won't be able to merge 6 and 7 for
4.12.  That said, it's a whole lot less that the various downstream
kernels will need to pull for the Pi3 than they've been carrying around
until now :)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170317/0bbbbd3d/attachment.sig>
