From: dianders@chromium.org (Doug Anderson)
Date: Fri, 4 Sep 2015 10:50:19 -0700
Subject: [PATCH 5/9] drm: bridge/dw_hdmi: avoid being recursive in N
 calculation
In-Reply-To: <E1ZO6hX-0003NK-0H@rmk-PC.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hX-0003NK-0H@rmk-PC.arm.linux.org.uk>
Message-ID: <CAD=FV=WJAm=EpugwnnBjPKJV1OOybyE6hkdhU2RrN0AR2qae6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Sat, Aug 8, 2015 at 9:10 AM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> There's no need to be recursive when computing the N value for the ACR
> packet - we can instead calculate the multiplier prior to our switch()
> based lookup, and multiply the N value appropriately afterwards.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/gpu/drm/bridge/dw_hdmi.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)

For what it's worth, I backported this change into my local 3.14-based
tree and it worked for me.  It also looks good to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
