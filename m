From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 24 Apr 2014 15:57:27 -0700
Subject: [PATCH] imx-drm: fix hdmi hotplug detection initial state
In-Reply-To: <20140424220732.GE26756@n2100.arm.linux.org.uk>
References: <E1Wb5Nd-0002Ef-Es@rmk-PC.arm.linux.org.uk>
 <CAJ+vNU23SE7ZumL34+6Wsv9c6rvcLx6jYQ_ed4uUY6yyGBnRBw@mail.gmail.com>
 <20140424220732.GE26756@n2100.arm.linux.org.uk>
Message-ID: <CAJ+vNU0Tf6WnrRE-6FbJTFPrP6chfbaT5GTw5QbSWE2Hkemp8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 3:07 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Apr 24, 2014 at 02:00:49PM -0700, Tim Harvey wrote:
>> I'm still seeing issues with HDMI detect on powerup, at least on my
>> Gateworks Ventana boards (which have no voltage devider or anything
>> else on the HPD line to the IMX6 other than a TVS). I'm currently
>> using your latest imx-drm-staging branch and have applied this patch
>> on top of it. When I enable debug in imx-hdmi.c I see the following:
>
> So it's a similar setup to the Cubox-i.
>
<snip>
>
> which is only with imx-hdmi bound, no ldb.  The difference you will
> notice is that there's the "Console: switching ..." line, which is
> there because I have fbcon enabled.
>
> Therefore, I suspect that it is working as it should - if you enable
> fbcon, it should automatically initialise.  If you don't have fbcon
> enabled, then it'll probably wait for a userspace DRM driver to bring
> it up.
>

Russell,

Yes, your correct. If I enable fbcon it comes up at boot. But what if
I don't want fbcon? I have CONFIG_LOGO=y and I would expect that to
come up without needing to hotswap. Something must still be missing
that is getting taken care of by fbcon.

Thanks,

Tim
