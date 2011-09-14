From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 14 Sep 2011 00:12:40 -0300
Subject: [PATCH] ARM: mach-mxs/mx28evk: Only register devices if their
	GPIO requests succeeded
In-Reply-To: <20110914031803.GC2368@S2100-06.ap.freescale.net>
References: <1315945519-15178-1-git-send-email-festevam@gmail.com>
	<20110914031803.GC2368@S2100-06.ap.freescale.net>
Message-ID: <CAOMZO5C29LY2_zj3jh1k1ygy+v+m+RioKVdrKGQ46N4=sWA7ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 12:18 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Tue, Sep 13, 2011 at 05:25:19PM -0300, Fabio Estevam wrote:
>> Currently framebuffer and MMC devices are registered even if their associated
>> GPIO pins fail to be requested.
>>
>> Change the logic so that the registration of such devices only occurs if their
>> GPIO requests succeeded.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
> So the question is whether the gpio request failure is a show-stopper
> failure for framebuffer and mmc.

If the GPIO that controls LCD enable or backlight enable failed it is
not very useful to register the framebuffer, do you agree?

Same for MMC.

You did the same logic for the CAN bus, so I extended it for the
framebuffer and MMC.

Regards,

Fabio Estevam
