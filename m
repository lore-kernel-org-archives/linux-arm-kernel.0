From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 12 Apr 2016 00:42:45 +0200
Subject: [PATCH v5 00/46] pwm: add support for atomic update
In-Reply-To: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160412004245.715db791@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On Wed, 30 Mar 2016 22:03:23 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hello,
> 
> This series adds support for atomic PWM update, or IOW, the capability
> to update all the parameters of a PWM device (enabled/disabled, period,
> duty and polarity) in one go.
> 
> It also adds support for initial PWM state retrieval (or hardware readout),
> which should allow smooth handover between the bootloader and Linux. For
> example, critical PWM users (like critical regulators controlled by a PWM)
> can query the current PWM state, and adapt the PWM config without having
> to disable/enable the PWM, or abruptly change the period/dutycyle/polarity
> config.
> 
> Thierry, I hope this version meets your expectations, if that's not the
> case, could you let me know quickly so I can adjust the implementation
> accordingly (I'd really like to get most of those changes in 4.7).

Still haven't had a clear feedback from your side on this series (you
commented on a few details, but nothing on the general approach). Could
you please have at a quick look at it, and let me know if I should
adjust the implementation?

Note that I plan to send a new version  addressing comments made by
other maintainers/developers by the end of the week. In the meantime,
could you have a look at the first set of patches (patch 1 to 4 are
completely independent), and apply them if you're happy with it.

As you can see, I now have a lot of patches. This helps in showing the
big picture, but also annoys people when I send this 50+ patchset. So,
if you don't mind, I'd like to drop the changes touching PWM user
drivers (to make them use the atomic API) until we get the other parts
applied.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
