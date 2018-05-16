From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 16 May 2018 10:57:06 +0200
Subject: [PATCH 1/4] amba: Export amba_bustype
In-Reply-To: <20180515134144.GF16141@n2100.armlinux.org.uk>
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
 <CAPDyKFqagt5zhz-8hLSXOqofv-nBqg4i-EVjA=UV3Jfi4zktKg@mail.gmail.com>
 <20180515134144.GF16141@n2100.armlinux.org.uk>
Message-ID: <CAPDyKFp-CRiUJq-kS5GqguncaEJE7wBsTHy_orQO_rmS-xzgBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 May 2018 at 15:41, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> On Tue, May 15, 2018 at 08:59:02AM +0200, Ulf Hansson wrote:
>> On 8 May 2018 at 21:06, Kim Phillips <kim.phillips@arm.com> wrote:
>> > This patch is provided in the context of allowing the Coresight driver
>> > subsystem to be loaded as modules.  Coresight uses amba_bus in its call
>> > to bus_find_device() in of_coresight_get_endpoint_device() when
>> > searching for a configurable endpoint device.  This patch allows
>> > Coresight to reference amba_bustype when built as a module.
>>
>> Sounds like you are fixing a bug, don't your want this to go for
>> stable and then also add a fixes tag?
>
> What bug is this fixing exactly that would qualify it for stable
> backporting?

That was my question, as when reading the changelog of $subject patch,
this isn't clear to me.

>
> The lack of an export is never a bug unless there is some existing
> user which requires it.  This is not the case here.
>
> What Kim is doing in his new patch series is making Coresight - which
> is currently only available as either disabled or built-in - possible
> to be loaded as a module.  This is a new feature, and in the process
> of creating this new feature, Kim needs a symbol that wasn't previously
> needed to be exported.

Thanks for clarifying, I did not review the entire series. The change
make perfect sense, no objections - and of course I agree it's not a
bug fix.

[...]

Kind regards
Uffe
