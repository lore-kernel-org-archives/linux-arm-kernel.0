From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 19 Apr 2013 01:17:44 -0300
Subject: [PATCH V3] ARM: i.MX5: Allow DT clock providers
In-Reply-To: <20130418161424.GI1906@pengutronix.de>
References: <20130418155510.26908.61334.stgit@localhost>
 <20130418161424.GI1906@pengutronix.de>
Message-ID: <CAOMZO5BKCvjOP6i7kcqqnd-TfSezWN3qQ942Bok8iW+3u5mwPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 1:14 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Thu, Apr 18, 2013 at 05:55:10PM +0200, Martin Fuzzey wrote:
>> Currently clock providers defined in the DT are not registered
>> on i.MX5 platforms since of_clk_init() is not called.
>>
>> This is not a problem for the SOC's own clocks, which are registered
>> in code,  but prevents the DT being used to define clocks for external
>> hardware.
>>
>> Fix this by calling of_clk_init() and actually using the DT to obtain
>> the 4 SOC fixed clocks.
>> These are already defined in the DT but were previously just used to
>> manually obtain the rate.
>>
>> Fall back to the old scheme for non DT platforms.
>>
>> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>

On a mx51evk:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

> I just realized that this is useful for other i.MX aswell. How about
> renaming it to imx_obtain_fixed_clk() and move it to
> arch/arm/mach-imx/clk.c?

Exactly. I was about to make the same suggestion.
