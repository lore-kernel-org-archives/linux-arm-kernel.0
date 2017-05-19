From: eric@anholt.net (Eric Anholt)
Date: Fri, 19 May 2017 12:33:13 -0700
Subject: [PATCH v2 1/5] drm/stm: ltdc: Add bridge support
In-Reply-To: <1495207218-11372-2-git-send-email-philippe.cornu@st.com>
References: <1495207218-11372-1-git-send-email-philippe.cornu@st.com>
 <1495207218-11372-2-git-send-email-philippe.cornu@st.com>
Message-ID: <87h90gfxqe.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Philippe CORNU <philippe.cornu@st.com> writes:

> Add the bridge support, used by DSI host and HDMI/LVDS bridges.
>
> Signed-off-by: Philippe CORNU <philippe.cornu@st.com>

The DW DSI host is bridging from MIPI DPI to MIPI DSI, right?  I think
you could just have ltdc always set up a DPI encoder (the
ltdc_rgb_encoder_create() function), and then depending on whether
drm_of_find_panel_or_bridge() finds you a panel or a bridge, you
drm_panel_attach() or drm_bridge_attach().

You wouldn't even need to wrap the drm_panel_prepare() and related calls
with a check for the panel, because the inlines already do that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170519/5b2ecd02/attachment.sig>
