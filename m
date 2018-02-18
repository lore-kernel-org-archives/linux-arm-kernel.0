From: david@lechnology.com (David Lechner)
Date: Sat, 17 Feb 2018 21:41:01 -0600
Subject: [PATCH 0/7] ARM: davinci: add genpd support
In-Reply-To: <a736d727-5805-94ea-3e40-34fc4a6267ef@ti.com>
References: <20180207134553.13510-1-brgl@bgdev.pl>
 <4dbc57ec-3506-eb1d-e00d-adfe75c3b39b@lechnology.com>
 <a736d727-5805-94ea-3e40-34fc4a6267ef@ti.com>
Message-ID: <79a981ae-881f-b358-629c-0b64e48f192d@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2018 06:42 AM, Sekhar Nori wrote:
> Hi David,
> 
> On Thursday 08 February 2018 04:13 AM, David Lechner wrote:
>> On 02/07/2018 07:45 AM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> Hi Sekhar et al,
>>>
>>> please take a look at the following patches. They add a simple genpd
>>> driver and use it in DT mode on da850 boards.
>>>
>>> I was trying to use genpd in legacy mode too, but couldn't find neither
>>> any interfaces nor users that would do that. For now I added a check in
>>> arch/arm/mach-davinci/pm_domain.c that disables the clock pm setup if
>>> we're using genpd.
>>>
>>> This series applies on top of and has been tested with David Lechner's
>>> for-bartosz branch. It fixes the clock look-up issues we faced with
>>> lcdc and emac.
>>
>> I'm starting to think that it makes more sense to just make the PSC driver
>> a power-domain and reset provider rather than a clock provider. It is
>> unfortunate that genpd is DT only.
> 
> This will mean that the only way to enable clocks on DaVinci is to use
> pm_runtime() calls. We do still have drivers which depend on clk api for
> enabling clocks, so I am not sure its feasible just yet.
> 
> I think a question like this can arise for any gate clock.
> 

I've incorporated parts of this series into my v7 work in progress
using the suggestions I made about using the existing PSC device
as the power domain provider.
