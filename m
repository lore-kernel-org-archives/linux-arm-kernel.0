From: dianders@chromium.org (Doug Anderson)
Date: Thu, 21 Aug 2014 18:15:13 -0700
Subject: [PATCH v3] i2c: rk3x: fix bug that cause transfer fails in master
 receive mode
In-Reply-To: <1408669991-9703-1-git-send-email-addy.ke@rock-chips.com>
References: <1408657107-8715-1-git-send-email-addy.ke@rock-chips.com>
 <1408669991-9703-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <CAD=FV=XY73RU1B4i1NEBffiRTbwMO_0Z9+Lh96-sckQmkH8Ogg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addy,

On Thu, Aug 21, 2014 at 6:13 PM, Addy Ke <addy.ke@rock-chips.com> wrote:
> In rk3x SOC, the I2C controller can receive/transmit up to 32 bytes data
> in one chunk, so the size of data to be write/read to/from TXDATAx/RXDATAx
> must be less than or equal 32 bytes at a time.
>
> Tested on rk3288-pinky board, elan receive 158 bytes data.
>
> Acked-by: Max Schwarz <max.schwarz@online.de>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
> Changes in v2:
> - Use cleaner syntax as suggested by Sergei.
> - Update commit message as suggested by Wolfram.
>
> Changes in v3:
> - fix typo: maste --> master and double spaces after 'len'
>
>  drivers/i2c/busses/i2c-rk3x.c | 4 ++++
>  1 file changed, 4 insertions(+)

Oops, we collided in the ether.  This looks good to me.

Tested-by: Doug Anderson <dianders@chromium.org>
