From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 22 Apr 2013 12:08:38 +0300
Subject: Multiple issues with omap4 panda es in linux next
In-Reply-To: <20130419171318.GK10155@atomide.com>
References: <20130419171318.GK10155@atomide.com>
Message-ID: <5174FE16.6080307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-04-19 20:13, Tony Lindgren wrote:

> 3. DSS fails with DT booting
> 
> Works with legacy booting but fails with DT. I'm almost certain
> the DT booting was working last week or so?
> 
> This is what I now get with DT booting:
> 
> omapdss DSI error: can't get VDDS_DSI regulator
> omapdss HDMI error: can't get VDDA_HDMI_DAC regulator
> omapdss HDMI error: device hdmi init failed: -517
> omapdss CORE error: driver probe failed: -22
> ...

I think this is the issue Christoph Fritz reported earlier, DSS is being
initialized before TWL, and thus DSS doesn't find the regulators.

The proper fix is of course to make DSS support EPROBE_DEFER, but that's
easier said than done. I'll have a look if I can get it working enough
to fix this issue.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130422/88930a19/attachment-0001.sig>
