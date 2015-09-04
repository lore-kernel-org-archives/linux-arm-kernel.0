From: dianders@chromium.org (Doug Anderson)
Date: Fri, 4 Sep 2015 11:24:20 -0700
Subject: [PATCH 7/9] drm: bridge/dw_hdmi: remove ratio support from ACR
 code
In-Reply-To: <E1ZO6hh-0003Nc-A7@rmk-PC.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hh-0003Nc-A7@rmk-PC.arm.linux.org.uk>
Message-ID: <CAD=FV=VFHt5PSJ_ocsL5pORwhuZHd3fSRa9DXdcKL2_7xW23Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Sat, Aug 8, 2015 at 9:10 AM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> We never set the ratio for CTS/N calculation for the audio clock
> regenerator (ACR) to anything but 100, so this adds pointless
> complexity.  Should we support pixel repetition, we should update the
> CTS/N calculation code to use those parameters or the actual TMDS clock
> rate instead of a ratio.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/gpu/drm/bridge/dw_hdmi.c | 44 ++++++++++++++++------------------------
>  1 file changed, 18 insertions(+), 26 deletions(-)

It looks like I've got a slightly older version of the driver in my
tree (based on some earlier mailing list postings), but backporting
this was pretty trivial and I've tried it in my 3.14 kernel.  It
doesn't cause any problems for me to remove the "radio" and I agree
that we should add it if/when pixel repetition is added.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
