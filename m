From: david@lechnology.com (David Lechner)
Date: Wed, 7 Feb 2018 16:43:50 -0600
Subject: [PATCH 0/7] ARM: davinci: add genpd support
In-Reply-To: <20180207134553.13510-1-brgl@bgdev.pl>
References: <20180207134553.13510-1-brgl@bgdev.pl>
Message-ID: <4dbc57ec-3506-eb1d-e00d-adfe75c3b39b@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2018 07:45 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Hi Sekhar et al,
> 
> please take a look at the following patches. They add a simple genpd
> driver and use it in DT mode on da850 boards.
> 
> I was trying to use genpd in legacy mode too, but couldn't find neither
> any interfaces nor users that would do that. For now I added a check in
> arch/arm/mach-davinci/pm_domain.c that disables the clock pm setup if
> we're using genpd.
> 
> This series applies on top of and has been tested with David Lechner's
> for-bartosz branch. It fixes the clock look-up issues we faced with
> lcdc and emac.

I'm starting to think that it makes more sense to just make the PSC driver
a power-domain and reset provider rather than a clock provider. It is
unfortunate that genpd is DT only.
