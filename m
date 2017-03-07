From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Tue, 07 Mar 2017 13:20:19 -0500
Subject: [RESEND PATCH 0/3] pwm: lpc32xx: switch driver to one phandle
 argument for PWM consumers
In-Reply-To: <20170216202749.20653-1-slemieux.tyco@gmail.com>
References: <20170216202749.20653-1-slemieux.tyco@gmail.com>
Message-ID: <1488910819.4022.2.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-02-16 at 15:27 -0500, slemieux.tyco at gmail.com wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
> 
> The change adds private of_xlate() function to process one argument given along with a PWM phandle. LPC32xx SoCs have two independent single channel PWM controllers, the argument is used as a description of PWM output frequency, see previous discussion here:
> 
>   http://www.spinics.net/lists/arm-kernel/msg534068.html
> 
> The changes on actual board dts files are not needed at the moment, because all LPC32xx boards in upstream don't describe any PWM consumers.
> 
> Please refer to the following URL to view the previous patch #1 review discussion:
>   http://www.spinics.net/lists/arm-kernel/msg549772.html
> 
Hi Thierry,

can you take this patchset for 4.12?

Let me know if you have more questions.

Regards,
Sylvain

> The "Reviewed-by" and "Acked-by" from the original posting are added into this resend.
> 
> Vladimir Zapolskiy (3):
>   dt: pwm: lpc32xx: add description of clocks and #pwm-cells properties
>   pwm: lpc32xx: switch driver to one phandle argument for PWM consumers
>   pwm: lpc32xx: remove handling of PWM channels
> 
>  .../devicetree/bindings/pwm/lpc32xx-pwm.txt        |  7 +++++
>  drivers/pwm/pwm-lpc32xx.c                          | 36 +++++++++++++++-------
>  2 files changed, 32 insertions(+), 11 deletions(-)
> 
