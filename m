From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 Oct 2015 15:01:36 -0300
Subject: [PATCH 11/12] drm: bridge/dw_hdmi: add connector mode forcing
In-Reply-To: <E1ZO6bY-0002vr-9R@rmk-PC.arm.linux.org.uk>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
 <E1ZO6bY-0002vr-9R@rmk-PC.arm.linux.org.uk>
Message-ID: <CAOMZO5C-_N0=JS9+CbrcS7xtKy-ZS51-tGY87m3mdmnduW76bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 8, 2015 at 1:04 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> When connected to HDMI sources, some DVI monitors de-assert their HPD
> signal and TDMS loads for one seconds every four seconds when there is
> no signal present on the connection.
>
> Unfortunately, this behaviour is indistinguishable from a proper HDMI
> setup with an AV receiver in the path to the display: the HDMI spec
> requires us to detect HPD deassertions as short as 100ms, which indicate
> that the EDID has changed.
>
> Since it is possible to connect a DVI monitor to an AV receiver and then
> to a HDMI source, merely working around this by detecting the lack of
> HDMI vendor block in the EDID is insufficient - the AV receiver is at
> liberty to modify the EDID as it sees fit, and it will place its own
> parameters into the EDID including the HDMI vendor block.
>
> DRM has support for forcing the state of a connector, which we should
> implement to allow us to work around these broken DVI monitors - we can
> tell DRM to force the connection state to indicate that there is always
> a device connected to work around this problem.  Although this requires
> manual configuration, it is better than nothing at all.
>
> When a forced connection state has been set, there is no point handling
> our RXSENSE interrupts, so disable them in this circumstance.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Fabio Estevam at freescale.com
