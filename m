From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 19 Jul 2014 12:47:38 +0200
Subject: [PATCH 00/14] clk: sunxi: Improve MMC clocks support
In-Reply-To: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <53CA4CCA.5040303@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/17/2014 11:08 AM, Maxime Ripard wrote:
> Hi everyone,
>
> Here is an attempt at improving the MMC clock support in the Allwinner
> SoCs.
>
> Until now, the MMC clocks were having a custom phase function that was
> directly setting an obscure value in the right register, because we
> were not really having any idea of what these values were.
>
> Now that we have more informations, we can introduce a common function
> call to get and set the phase of a particular clock, and use this in
> both our provider and our client.
>
> Another issue we had so far on the A13 was that, out of reset, the
> PLL6 driving the MMC was running too high to be working. We can solve
> that by adding two new properties in the DT to setup the rate
> constraints we might have on a clock.

Looks good to me, thanks for working on this.

Question have you dumped the raw mmc0 clk reg before and after this
patch set to verify that the end result is the same ?

Regards,

Hans
