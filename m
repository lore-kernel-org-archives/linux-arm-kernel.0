From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 6 Mar 2014 12:21:34 +0200
Subject: [PATCH v5 1/2] video: ARM CLCD: Add DT support
In-Reply-To: <1394036606-17784-1-git-send-email-pawel.moll@arm.com>
References: <1394036606-17784-1-git-send-email-pawel.moll@arm.com>
Message-ID: <53184C2E.3000807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

On 05/03/14 18:23, Pawel Moll wrote:
> This patch adds basic DT bindings for the PL11x CLCD cells
> and make their fbdev driver use them.

Is this an old HW, and presumably there won't be new users for it? If
yes, this is probably fine. If not, you might want to look at the video
ports and endpoints, which is used by at least three not-yet-merged series:

[PATCHv3 00/41] OMAPDSS: DT support v3
[PATCH v5 00/11] imx-drm dt bindings
[RFC PATCH v2 00/21] Add DSI display support for Exynos based boards

Using bindings like that would be more future proof, even if the current
driver doesn't use them.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140306/96146f79/attachment.sig>
