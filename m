From: dianders@chromium.org (Doug Anderson)
Date: Fri, 22 Aug 2014 11:33:02 -0700
Subject: [PATCH v4] i2c: rk3x: fix bug that cause transfer fails in master
 receive mode
In-Reply-To: <1408730452-3552-1-git-send-email-addy.ke@rock-chips.com>
References: <1408669991-9703-1-git-send-email-addy.ke@rock-chips.com>
 <1408730452-3552-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <CAD=FV=Vof8mOmCHkRyrhjGBewJqJaCu==1RfUZ+8C9Jm+UH50w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addy,

On Fri, Aug 22, 2014 at 11:00 AM, Addy Ke <addy.ke@rock-chips.com> wrote:
> In rk3x SOC, the I2C controller can receive/transmit up to 32 bytes data
> in one chunk, so the size of data to be write/read to/from TXDATAx/RXDATAx
> must be less than or equal 32 bytes at a time.
>
> Tested on rk3288-pinky board, elan receive 158 bytes data.
>
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

You only need a "Suggested-by" if the entire patch was suggested by
someone.  If someone provides you review feedback you don't need it.

Said another way: in this case Dmitry didn't suggest that you need to
fix the i2c controller to transmit 32 byte chunks (he only provided
review feedback), so you shouldn't say this was Suggested-by him.

You also had my reviewed-by on a previous version so you could keep it.

Reviewed-by: Doug Anderson <dianders@chromium.org>
