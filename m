From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 4 Nov 2009 22:44:38 +0800
Subject: [PATCH] ARM: pxafb: Use the passed fb_var_screeninfo struct in
	pxafb_pan_display()
In-Reply-To: <20091030111920.GC14091@buzzloop.caiaq.de>
References: <20091022063434.GQ14091@buzzloop.caiaq.de>
	<20091028001805.GC14091@buzzloop.caiaq.de>
	<f17812d70910271913l15950170we45290bb1892761a@mail.gmail.com>
	<20091029195156.GI22046@sci.fi>
	<20091030111920.GC14091@buzzloop.caiaq.de>
Message-ID: <f17812d70911040644l2cb76f0en222ae5bb63a57e43@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Commit 3a8552e made pxafb pay attention to paramters passed to
> pxafb_pan_display(). As Ville Syrj?l? pointed out, this is potentially
> dangerous as user could pass in any other screeninfo parameters as well,
> and not only such that are relevant for display panning.
>
> This patch fixed that by limiting the arguments actually used to
> .xoffset, .yoffset and .vmode & FB_VMODE_YWRAP.
>
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Ville Syrj?l? <syrjala@sci.fi>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Sven Neumann <s.neumann@raumfeld.com>

OK, merged with the previous commit with additional comments of
the issue found, and with Ville Syrj?l? <syrjala@sci.fi> in the Cc
list. Thanks.
