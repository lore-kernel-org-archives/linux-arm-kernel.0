From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 11 Apr 2012 23:15:43 +0200
Subject: [PATCH 06/12] arm: omap3: am35x: Add full PWRDM_POWER_INACTIVE
 support
In-Reply-To: <20120411211416.GB7979@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-7-git-send-email-mgreer@animalcreek.com>
 <CAORVsuW2Nax4h+SxEJ6dLM1AopAFPQjvK0FHa9N5mEEVCStpQw@mail.gmail.com>
 <alpine.DEB.2.00.1204111506240.29473@utopia.booyaka.com>
 <20120411211416.GB7979@animalcreek.com>
Message-ID: <CAORVsuW-Pz1ewrBVT_KOrLbtzOBcdkRgo53NDKh7ctRT=PzHpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 11:14 PM, Mark A. Greer <mgreer@animalcreek.com> wrote:
> On Wed, Apr 11, 2012 at 03:08:54PM -0600, Paul Walmsley wrote:
>> Hi
>>
>> On Wed, 11 Apr 2012, Jean Pihet wrote:
>>
>> > On Wed, Apr 11, 2012 at 9:05 PM, Mark A. Greer <mgreer@animalcreek.com> wrote:
>> > > From: "Mark A. Greer" <mgreer@animalcreek.com>
>> > >
>> > > The am35x family of SoCs only support PWRDM_POWER_ON
>> > > and PWRDM_POWER_INACTIVE power states. This causes
>> > > an issue in some areas of the OMAP3 power-related
>> > > code because of assumptions that PWRDM_POWER_RET
>> > > and/or PWRDM_POWER_OFF are always valid states.
>> > >
>> > > To get am35x SoCs to work properly, add missing support
>> > > for PWRDM_POWER_INACTIVE and remove assumptions that
>> > > PWRDM_POWER_RET and PWRDM_POWER_OFF are always valid states.
>> > >
>> > > Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
>> >
>> > I just posted a patch set '[RFC/PATCH v2 0/6] ARM: OMAP2+: PM:
>> > introduce the power domains functional states' [1] which I think
>> > should be used to base your patches on. This patch set introduces
>> > functional states for the power domains power ans logic states, and
>> > the conversion functions between the internal power and logic states
>> > and the functional states.
>> >
>> > I would be glad to help on the AM35x support for the functional states.
>>
>> Since it might take a while for the functional powerstate code to go
>> upstream, if Mark wants to do this, I'd suggest that he split the
>> powerdomain-specific patches off from the rest of his series. ?This should
>> avoid blocking the rest of his patches on the infrastructure changes.
>
> Another good idea. ?I'll do the split in another day or so in case there
> are more comments I can address when I respin & separate the patches.
Sounds great!

Regards,
Jean

>
> Mark
> --
