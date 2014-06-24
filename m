From: denis@eukrea.com (Denis Carikli)
Date: Tue, 24 Jun 2014 18:25:19 +0200
Subject: [PATCH v14 04/10] imx-drm: use defines for clock polarity settings
In-Reply-To: <20140624151323.GU32514@n2100.arm.linux.org.uk>
References: <1402913484-25910-1-git-send-email-denis@eukrea.com>
 <1402913484-25910-4-git-send-email-denis@eukrea.com>
 <20140624151323.GU32514@n2100.arm.linux.org.uk>
Message-ID: <53A9A66F.20401@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2014 05:13 PM, Russell King - ARM Linux wrote:
[...]
> If you'd like to send me better commit messages for
> these patches, I'll add them to what I already have:

> 	imx-drm: use defines for clock polarity settings
The comment of the clk_pol field of the ipu_di_signal_cfg struct was 
inverted.
Instead of merely inverting the comment, the values of clk_pol were defined.

> 	imx-drm: add RGB666 support for parallel display.
This permits to drive parallel displays that expect the RGB666 color format.
>
> It may also be worth describing the RGB666 format in the commit message
> for:
>
> 	v4l2: add new V4L2_PIX_FMT_RGB666 pixel format.
The RGB666 color format encodes 6 bits for each color(red, green and 
blue), linearly.
It looks like this in memory:
0                17
RRRRRRGGGGGGBBBBBB

Denis.
