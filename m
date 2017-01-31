From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Jan 2017 01:06:53 +0000
Subject: [PATCH v3 00/24] i.MX Media Driver
In-Reply-To: <20170131004510.GQ27312@n2100.armlinux.org.uk>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <20170131004510.GQ27312@n2100.armlinux.org.uk>
Message-ID: <20170131010653.GR27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 12:45:11AM +0000, Russell King - ARM Linux wrote:
> Trying this driver with an imx219 camera (which works with Philipp's
> driver) results in not much happening... no /dev/media* node for it,
> no subdevs, no nothing.  No clues as to what's missing either.  Only
> messages from imx-media are from registering the various subdevs.

Another issue:

imx_csi                 5491  4
imx_camif              11654  4
imx_ic                 23961  8
imx_smfc                6639  4
imx_media              23308  1 imx_csi
imx_mipi_csi2           5544  1
imx_media_common       12701  6 imx_csi,imx_smfc,imx_media,imx_mipi_csi2,imx_camif,imx_ic
imx219                 21205  2

So how does one remove any of these modules, say, while developing a
camera driver?  Having to reboot to test an update makes it painfully
slow for testing.

Philipp's driver can do this (once the unload bugs are fixed, which I
have patches for).

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
