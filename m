From: dianders@chromium.org (Doug Anderson)
Date: Wed, 2 Sep 2015 16:34:38 -0700
Subject: [PATCH v2 1/2] ARM: dts: rockchip: pull up cts lines on rk3288
In-Reply-To: <1441236479-4941-2-git-send-email-amstan@chromium.org>
References: <1441236479-4941-1-git-send-email-amstan@chromium.org>
 <1441236479-4941-2-git-send-email-amstan@chromium.org>
Message-ID: <CAD=FV=XRLnz3FTbwg1u2Jwg=a3dim6vwLk0yGc9kK=RGYDvxXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alex,

On Wed, Sep 2, 2015 at 4:27 PM, Alexandru M Stan <amstan@chromium.org> wrote:
> The flow control lines from a user accessible UART are optional,
> the user might not have anything connected to those pins.
> In order to prevent random interrupts happening and noise affecting
> the cts pin should be pulled up.
>
> Note that the default state for that pin on the rk3288 is pulled up,
> so this patch merely restores them.
>
> This is similar to what we're already doing with the RX pin,
> so it should be safe. At worst it might be a slightly higher power usage
> (through ~50 kohms) when the cts is low.
>
> Suggested-by: Neil Hendin <nhendin@chromium.org>
> Signed-off-by: Alexandru M Stan <amstan@chromium.org>
> ---
> Changes in v2: None

Probably not entirely true.  ;)

>  arch/arm/boot/dts/rk3288.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Looks good to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
