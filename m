From: agnel.joel@gmail.com (Joel A Fernandes)
Date: Sat, 15 Jun 2013 02:23:32 -0500
Subject: [PATCH 2/2] ARM: dts: add AM33XX MMC support
In-Reply-To: <CAD=GYpYfMAZeV1RUC=DqhYGZaKiiukpTZg7bhO582eKwimS9aA@mail.gmail.com>
References: <41fde401c8e646689123d7c6d3a2dffc@DLEE71.ent.ti.com>
 <20130307141235.GQ6209@beef>
 <79CD15C6BA57404B839C016229A409A83EC20C57@DBDE01.ent.ti.com>
 <20130307144656.GR6209@beef>
 <79CD15C6BA57404B839C016229A409A83EC20CCA@DBDE01.ent.ti.com>
 <20130307150408.GU6209@beef>
 <79CD15C6BA57404B839C016229A409A83EC20D27@DBDE01.ent.ti.com>
 <20130307160236.GV6209@beef>
 <79CD15C6BA57404B839C016229A409A83EC213C8@DBDE01.ent.ti.com>
 <CAD=GYpb3+nvoz863+VKO7iJijRHnM5RzsVj-5VJfQ-OHoUy19Q@mail.gmail.com>
 <20130614222537.GA25428@arwen.pp.htv.fi>
 <CAD=GYpYfMAZeV1RUC=DqhYGZaKiiukpTZg7bhO582eKwimS9aA@mail.gmail.com>
Message-ID: <CAD=GYpbvy0B5pjq_zdGg-anUAB2rhzN5EYKRy-RV2_Bqj9SHKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Fri, Jun 14, 2013 at 6:43 PM, Joel A Fernandes <agnel.joel@gmail.com> wrote:
> Felipe,
>
>
> On Friday, June 14, 2013, Felipe Balbi wrote:
>>
>> Hi,
>>
>> On Fri, Jun 14, 2013 at 02:54:33PM -0500, Joel A Fernandes wrote:
>> > Hi Tony, Vaibhav,
>> >
>> > >> I just doublechecked MMC rootfs on bone and evmsk as it's the
>> > >> standard
>> > >> smoke test. My EVM is intermittent now so trying to coax it to power
>> > >> up
>> > >> to reverify.
>> > >>
>> > >
>> > > Matt,
>> > >
>> > > Your branch is working for me, I tested it on EVM. Not sure what is
>> > > wrong with manual rebasing
>> > > I did yesterday. I will try to nail-down root-cause here.
>> > >
>> > > And you can submit the next version fixing the comments I have given.
>> >
>> > The only comment I could find in the whole discussion was adding of
>> > the interrupts property. I tested I don't have any problem booting
>> > with Matt's patch, without having the interrupts property.
>>
>> might very well be, but we want to figure out why adding "intrrupts"
>> causes issues. Why does it have to come through hwmod ? You might have
>> uncovered a real problem which needs fixing. Besides, at the end of the
>

You are right, adding interrupts property to DT node causes problems
(driver probe doesn't take place). Will debug further on Monday.

Thanks,
Joel
