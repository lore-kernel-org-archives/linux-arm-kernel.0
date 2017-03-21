From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Tue, 21 Mar 2017 16:46:02 -0700
Subject: [PATCH 3/4] media: imx-csi: add frame size/interval enumeration
In-Reply-To: <E1cpYOU-0006En-Vd@rmk-PC.armlinux.org.uk>
References: <20170319103801.GQ21222@n2100.armlinux.org.uk>
 <E1cpYOU-0006En-Vd@rmk-PC.armlinux.org.uk>
Message-ID: <c797369f-f4b9-e216-f594-d142d1786549@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 03/19/2017 03:49 AM, Russell King wrote:
> Add frame size and frame interval enumeration to CSI.
>
> CSI can scale the image independently horizontally and vertically by a
> factor of two, which enumerates to four different frame sizes.
>
> CSI can also drop frames, resulting in frame rate reduction, so
> enumerate the resulting possible output frame rates.
>

I applied this patch, modified to return a frame size range on the
sink pad. Also, I believe both frame size and frame interval
enumeration should base their decision making on the crop rectangle
at the sink pad, not on the format at the source pads, due to the
crop/compose re-org patch from Philipp.

The updated patch is attached.

Steve

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0036-media-imx-csi-add-frame-size-interval-enumeration.patch
Type: text/x-patch
Size: 3305 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170321/0809b6dc/attachment.bin>
