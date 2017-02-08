From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 8 Feb 2017 08:52:19 +0100
Subject: [PATCH v2 1/4] ARM: pwm: sun4i: unification of register
 operations for support sun6i.
In-Reply-To: <1486489846-662-2-git-send-email-lis8215@gmail.com>
References: <1486489846-662-1-git-send-email-lis8215@gmail.com>
 <1486489846-662-2-git-send-email-lis8215@gmail.com>
Message-ID: <20170208075219.oo234d5zartzmzsg@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 07, 2017 at 08:50:43PM +0300, lis8215 at gmail.com wrote:
> From: Siarhei Volkau <lis8215@gmail.com>
> 
> This patch not introduce new features, just prepare code for
> adding sun6i PWM driver in next commits.
> 
> A31 SoC have a different map of PWM registers than others ASoCs,
> but register bits purposes are very similar.
> 
> This patch introduce set of register access routines, which
> are common for existing in driver ASoCs:
>  - ctl_rdy   - checks the ready bit of specified PWM channel,
>  - ctl_read  - reads value from control register of specified PWM channel,
>  - ctl_write - writes significant bits to control register of specified PWM channel,
>  - prd_read  - reads value from period register of specified PWM channel,
>  - prd_write - writes value to period register of specified PWM channel.
> Driver code redesigned to use the new routines.

Why don't you use regmap for that?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170208/e431d57c/attachment-0001.sig>
