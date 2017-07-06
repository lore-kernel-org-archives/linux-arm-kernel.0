From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 6 Jul 2017 08:49:22 +0200
Subject: [PATCH v2 0/3] pwm: sun4i: switch to atomic PWM
In-Reply-To: <20170530193209.19247-1-alexandre.belloni@free-electrons.com>
References: <20170530193209.19247-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170706064922.GI16144@ulmo.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 30, 2017 at 09:32:06PM +0200, Alexandre Belloni wrote:
> Switch to atomic PWM. The main goal is to properly wait for a period before
> disabling a channel to ensure the correct level is set on the output.
> 
> Changes in v2:
>  - fixed remaining checkpatch warnings
>  - split the series to ease reviews
>  - changed the delay handling to ensure the proper amount of time has elapsed
>    before disabling a channel
>  - dropped RDY bit handling as it doesn't have any real effect.
> 
> Alexandre Belloni (3):
>   pwm: sun4i: improve hardware read out
>   pwm: sun4i: switch to atomic PWM
>   pwm: sun4i: drop legacy callbacks
> 
>  drivers/pwm/pwm-sun4i.c | 263 +++++++++++++++++++++++++++---------------------
>  1 file changed, 148 insertions(+), 115 deletions(-)

Series applied, though you could've just squashed together patches 2 and
3 because they don't make sense apart.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170706/9b5fb1ba/attachment.sig>
