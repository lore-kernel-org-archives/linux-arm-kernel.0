From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 17 Mar 2015 12:28:34 +0100
Subject: [PATCH v4 2/4] mmc: core: Add mmc_regulator_set_vqmmc()
In-Reply-To: <20150317103829.GA28806@sirena.org.uk>
References: <1426112117-18220-1-git-send-email-dianders@chromium.org>
 <1426112117-18220-2-git-send-email-dianders@chromium.org>
 <CAPDyKFq_WMJfqNGuxwN7xPmhv2X6-+G1zXpdD6zYDkDe7-Jo2A@mail.gmail.com>
 <CAD=FV=U-YnT5jF5MFC==hANXGPqVpV3iLMPu85TrQ4dNDsWeCA@mail.gmail.com>
 <CAPDyKFpG=q88QEkuAgoLqkZU40Kx7dB7PmnXHqEt0EtbYvR_Cg@mail.gmail.com>
 <20150317103829.GA28806@sirena.org.uk>
Message-ID: <CAPDyKFqGYqNCbGGzw7orXLT+pkxK5LMUDTYWju405tqynPMyCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 March 2015 at 11:38, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Mar 17, 2015 at 11:23:33AM +0100, Ulf Hansson wrote:
>> On 16 March 2015 at 16:12, Doug Anderson <dianders@chromium.org> wrote:
>
>> > * Try to set the voltage to exactly 1,200,000 uV (1.2V).
>> > * If you can't get 1.2V exactly, a tolerance ("tol") of 100,000 uV
>> > (.1V) is OK.
>> > * In other words, 1.1V - 1.3V are OK, but aim for 1.2V
>
>> So what happens in the case when 1.3V and 1.1V, but not 1.2V. Which
>> value will be used? Is that algorithm defined by the regulator core or
>> does it depend per regulator implementation?
>
> It's done in the core.  It first tries to hit the target voltage to the
> maximum (picking the lowest voltage in that range) then tries to pick
> the lowest voltage to the target, though that's an implementation detail
> and we really should be trying to get as close as possible to the
> target.  We don't do that yet because it can be expensive to work out so
> we do the current thing which is cheap and mostly good enough.

Okay, so that seems to work well for our 1.1V->1.3V case.

Thanks!

Kind regards
Uffe
