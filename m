From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Mon, 30 Jan 2017 18:06:33 -0800
Subject: [PATCH v3 00/24] i.MX Media Driver
In-Reply-To: <20170131010653.GR27312@n2100.armlinux.org.uk>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <20170131004510.GQ27312@n2100.armlinux.org.uk>
 <20170131010653.GR27312@n2100.armlinux.org.uk>
Message-ID: <396ef27c-4de2-a412-4369-9c33bf199826@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/30/2017 05:06 PM, Russell King - ARM Linux wrote:
> On Tue, Jan 31, 2017 at 12:45:11AM +0000, Russell King - ARM Linux wrote:
>> Trying this driver with an imx219 camera (which works with Philipp's
>> driver) results in not much happening... no /dev/media* node for it,
>> no subdevs, no nothing.  No clues as to what's missing either.  Only
>> messages from imx-media are from registering the various subdevs.
> Another issue:
>
> imx_csi                 5491  4
> imx_camif              11654  4
> imx_ic                 23961  8
> imx_smfc                6639  4
> imx_media              23308  1 imx_csi
> imx_mipi_csi2           5544  1
> imx_media_common       12701  6 imx_csi,imx_smfc,imx_media,imx_mipi_csi2,imx_camif,imx_ic
> imx219                 21205  2
>
> So how does one remove any of these modules, say, while developing a
> camera driver?  Having to reboot to test an update makes it painfully
> slow for testing.

Unload is not working yet, it's on the TODO list.

But FWIW, here's how it currently looks in version 4
(on the SabreSD):

imx_media_csi           9663  4
imx_media_ic           12688  6
imx_media_capture      10201  2 imx_media_ic,imx_media_csi
imx_media_vdic          6909  2
imx_mipi_csi2           6293  1
ov5640_mipi            25988  1
imx_media              15532  0
imx_media_common       16093  6 
imx_media_ic,imx_media,imx_media_csi,imx_mipi_cs
i2,imx_media_capture,imx_media_vdic


Steve


>
> Philipp's driver can do this (once the unload bugs are fixed, which I
> have patches for).
>
