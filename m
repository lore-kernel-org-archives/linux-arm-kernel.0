From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 18 Apr 2012 11:37:09 -0600
Subject: [PATCH 1/1] pinctrl: handle dummy state in core
In-Reply-To: <CACRpkdZw6iv=PjvvU4s5L8yV6813gCD7t8Vk-S66v-nXPaf+=Q@mail.gmail.com>
References: <1334586289-13078-1-git-send-email-b29396@freescale.com>	<4F8C42D6.2000607@wwwdotorg.org>	<20120417034210.GD17173@shlinux2.ap.freescale.net>	<CACRpkdYH06_kGbSdozKPWZcOG0FvoOyHvjHwhz-xUL1pfSX9DQ@mail.gmail.com>	<20120418122832.GP20478@pengutronix.de>
 <CACRpkdZw6iv=PjvvU4s5L8yV6813gCD7t8Vk-S66v-nXPaf+=Q@mail.gmail.com>
Message-ID: <4F8EFBC5.1030607@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2012 07:52 AM, Linus Walleij wrote:
> On Wed, Apr 18, 2012 at 2:28 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
>> Currently Dong Aisheng is working on i.MX6, we have i.MX31, i.MX35,
>> i.MX51 and i.MX53 enabled in the same defconfig. Waiting for all
>> machines turn over at once to pinctrl is illusionary. We have to make
>> drivers work with and without pinctrl. We have a bunch of bad choices:
>>
>> - create a dummy pinctrl for all boards which do not have real pinmux
>>  support
> 
> Viable compromise.
> 
>> - ignore pinctrl_request errors in drivers.
> 
> Ugh. Not good.
> 
>> - generate and return a dummy pinctrl in the core if no real pinctrl is
>>  found.
>>
>> (replace pinctrl with regulators or clocks, it's the same situation, and
>> it's not only i.MX specific)
> 
> Since we have dummy regulators, we should not break the design
> pattern creating more confusion.
> 
> Stephen can you live with dummy pinctrl handles emitted by the
> core, if explicitly enabled by a Kconfig option?

Yes, I'm happy with the pinctrl core having the ability to "magically"
work when the dummy mapping table entries (or DT entries) are missing,
so long as there is a default-off Kconfig or runtime option that enables
that feature, which I'd expect to be use only for boards/platforms/...
that are "under conversion".
