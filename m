From: dianders@chromium.org (Doug Anderson)
Date: Thu, 11 Dec 2014 11:22:31 -0800
Subject: [PATCH v5] i2c: rk3x: fix bug that cause measured high_ns doesn't
 meet I2C specification
In-Reply-To: <1418295760-19639-1-git-send-email-addy.ke@rock-chips.com>
References: <1418277650-25215-1-git-send-email-addy.ke@rock-chips.com>
 <1418295760-19639-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <CAD=FV=UCQMRLx2KHzT28iY6uCHGQ0MouWKEeVyv2AF_qNCrT=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 11, 2014 at 3:02 AM, Addy Ke <addy.ke@rock-chips.com> wrote:
>   - clock-frequency : SCL frequency to use (in Hz). If omitted, 100kHz is used.
> + - i2c-scl-rising-time-ns : Number of nanoseconds the signal takes to rise
> +       (t(r) in I2C specification). If not specified this is assumed to be
> +       the maximum the specification allows(1000 ns for Standard-mode,
> +       300 ns for Fast-mode) which might cause slightly slower communication.
> + - i2c-scl-falling-time-ns : Number of nanoseconds the signal takes to fall
> +       (t(f) in the I2C specification). If not specified this is assumed to
> +       be the maximum the specification allows (300 ns) which might cause
> +       slightly slowercommunication.

nit: you forgot a space between "slower" and "communication".

...this is the type of thing I think Wolfram can fixup when applying,
so I'd suggest against respinning unless something else is needed.

Overall I continue to be happy with this patch.

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>

You'll notice that I posted a patch atop it at
<https://patchwork.kernel.org/patch/5477201/>.

-Doug
