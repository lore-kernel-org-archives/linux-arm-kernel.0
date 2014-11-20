From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 20 Nov 2014 11:23:28 +0100
Subject: [PATCH 0/3] PM / Domains: Add initial PM clock support to genpd
In-Reply-To: <7hk32qu2w3.fsf@deeprootsystems.com>
References: <1416405638-18812-1-git-send-email-ulf.hansson@linaro.org>
 <7hk32qu2w3.fsf@deeprootsystems.com>
Message-ID: <CAPDyKFp=+e_C8c_9-syYEw7wNom3KgdOaNnGSUk+f52xSohqNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 November 2014 01:33, Kevin Hilman <khilman@kernel.org> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> It's quite common for PM domains to use PM clocks. Typically from SOC specific
>> code, the per device PM clock list is created and pm_clk_suspend|resume() are
>> invoked to handle clock gating/ungating.
>>
>> A step towards consolidation is to integrate PM clock support into genpd, which
>> is what this patchset does.
>>
>> In this initial step, the calls to the pm_clk_suspend|resume() are handled
>> within genpd, but the per device PM clock list still needs to be created from
>> SOC specific code. It seems reasonable to have gendp to handle that as well, but
>> that left to future patchsets to address.
>
> I think we need to get rid of the SoC specific code already.  For
> example, we're already seeing SoCs where the arm32 core is being
> replaced by an arm64 core but the other IPs, and power-domain logic is
> staying more or less the same.
>
>> It's not every users of genpd that are keen on using PM clocks thus we need
>> to provide this a configuration option for genpd.
>
> Or more likely, probably some compatible string, or property in the
> domain node.  Grygorii, Arnd and myself were discussing this elsewhere
> in the context of the TI Keystone2 PM domain support[1].

Thanks for pointing that out. It was actually the reason to why I
posted this patchset now, I have been keeping the patches locally in
my tree for too long. :-)

Let me comment of that thread, instead of here.

Kind regards
Uffe
