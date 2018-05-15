From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 15 May 2018 09:07:44 -0600
Subject: [PATCH 1/4] amba: Export amba_bustype
In-Reply-To: <20180515093718.19ca71295fc36fe65c5df021@arm.com>
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
 <CAPDyKFqagt5zhz-8hLSXOqofv-nBqg4i-EVjA=UV3Jfi4zktKg@mail.gmail.com>
 <20180515081519.22751a39c49e63224da3acac@arm.com>
 <20180515134831.GG16141@n2100.armlinux.org.uk>
 <20180515093718.19ca71295fc36fe65c5df021@arm.com>
Message-ID: <CANLsYkyND-hspG3zH5LwwcWTbb_s7WqcRFAAy1mNOhwQ3RNW9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 May 2018 at 08:37, Kim Phillips <kim.phillips@arm.com> wrote:
> On Tue, 15 May 2018 14:48:31 +0100
> Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
>
>> On Tue, May 15, 2018 at 08:15:19AM -0500, Kim Phillips wrote:
>> > On Tue, 15 May 2018 08:59:02 +0200
>> > Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> >
>> > > On 8 May 2018 at 21:06, Kim Phillips <kim.phillips@arm.com> wrote:
>> > > > This patch is provided in the context of allowing the Coresight driver
>> > > > subsystem to be loaded as modules.  Coresight uses amba_bus in its call
>> > > > to bus_find_device() in of_coresight_get_endpoint_device() when
>> > > > searching for a configurable endpoint device.  This patch allows
>> > > > Coresight to reference amba_bustype when built as a module.
>> > >
>> > > Sounds like you are fixing a bug, don't your want this to go for
>> > > stable and then also add a fixes tag?
>> >
>> > How do you consider this a bug fix?  What commit would the fixes tag
>> > reference?  The introduction of the amba bus?  Not only aren't busses
>> > required to export their bus_type, but that commit predates git.
>>
>> I do not consider it a bug fix (see my reply to Ulf) and I certainly
>
> I agree this isn't a bug fix.
>
>> The only problem which we're aware of is with Coresight, and only then
>> when your patches to allow Coresight to be modular are merged.  That's
>
> Just to clarify: the Coresight modularization patch depends on this
> patch, so this patch is to be merged first.

I think the whole feature should be merge at the same time and (with
Russell's ACK) probably easier through my tree.

>
> Cheers,
>
> Kim
