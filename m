From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 22 Sep 2016 00:03:40 +0300
Subject: [PATCH] drm/sun4i: rgb: Enable panel after controller
In-Reply-To: <20160921130304.3486-1-net147@gmail.com>
References: <20160921130304.3486-1-net147@gmail.com>
Message-ID: <20160921210340.GI8719@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 21, 2016 at 11:03:04PM +1000, Jonathan Liu wrote:
> The panel should be enabled after the controller so that the panel
> prepare/enable delays are properly taken into account. Similarly, the
> panel should be disabled before the controller so that the panel
> unprepare/disable delays are properly taken into account.
>
> This is useful for avoiding visual glitches.

This is not really taking any delays into account, especially since
drm_panel_enable and prepare are suppose to block until their
operation is complete.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160922/2c9d582c/attachment.sig>
