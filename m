From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 13 Dec 2015 22:07:19 +0100
Subject: [PATCH v2] spi: dts: sun4i: Add support for inter-word wait
 cycles using the SPI Wait Clock Register
In-Reply-To: <1449873940-10167-1-git-send-email-mweseloh42@gmail.com>
References: <1449873940-10167-1-git-send-email-mweseloh42@gmail.com>
Message-ID: <20151213210719.GC19456@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 11, 2015 at 11:45:39PM +0100, Marcus Weseloh wrote:
> Adds support and binding documentation for a new slave device property
> "sun4i,spi-word-wait-ns" that allows to set a hardware based delay
> between the transmission of words using the SPI Wait Clock Register.
> The SPI hardware needs 3 clock cycles to set up the delay, which makes
> the minimum non-zero wait time 4 clock cycles.
> 
> Signed-off-by: Marcus Weseloh <mweseloh42@gmail.com>
> ---
> Changes from v1:
>  * renamed the property for more clarity
>  * wait time is set in nanoseconds instead of number of clock cycles
>  * transparently handle the 3 setup clock cycles
> 
> There is one review comment that I didn't address: Rob Herring suggested
> that this should be in the core-binding rather than in sun4i. I checked
> many of the hardware manuals of other SPI drivers and it looks to me like
> this hardware based inter-word delay is a feature that not many SPI
> controllers offer. And the SPI core currently has no way to control an
> inter-word delay, only inter-message. So I would like to propose this again
> as a sun4i binding, as it targets a sun4i (or sunxi?) specific hardware
> feature.

Only a few of them justify to have this in the framework. There's a
bunch of controllers that support such a feature, and it definitely
belongs in the core.

The point of the framework is not to be the least common denominator,
it's about having as much code in common as possible, and it
definitely falls into that category.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151213/124a2070/attachment.sig>
