From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 2 May 2012 17:28:17 +0530
Subject: [PATCH 01/19] ARM: OMAP4: PM: save/restore all DPLL settings in
 OFF mode
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EA6DABF@DBDE01.ent.ti.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
 <1334914432-26456-2-git-send-email-t-kristo@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EA6B68E@DBDE01.ent.ti.com>
 <CAMQu2gwCstL6eF92_QBDYZaA5xwxD9a+YWRVxdghA5WVkp4PEQ@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433EA6C848@DBDE01.ent.ti.com>
 <CAMQu2gxcUw5A-p25xdYeXfy=tLbDNPsjV_5MJ6s5qGNfn4Zbfw@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433EA6D93B@DBDE01.ent.ti.com>
 <CAOMWX4cjjhDYjsdjUPj+mVx_GCZ_sMEB6X0N3bN4zMJGBFxZRQ@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433EA6DABF@DBDE01.ent.ti.com>
Message-ID: <CAMQu2gy4wLw=a07dnP5GgKwqMOGA5s-GUZa2+nbTrp6Q-NOxwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 2, 2012 at 5:25 PM, Bedia, Vaibhav <vaibhav.bedia@ti.com> wrote:
> On Wed, May 02, 2012 at 17:17:08, Menon, Nishanth wrote:
>> On Wed, May 2, 2012 at 6:40 AM, Bedia, Vaibhav <vaibhav.bedia@ti.com> wrote:
>> >
>> > On Wed, May 02, 2012 at 16:30:26, Shilimkar, Santosh wrote:
>> > [...]
>> >
>> > > >> How ?
>> > > >> SRAM is sower memory than DDR so I don't see how it
>> > > >> will reduce latency.
>> > > >>
>> > > >
>> > > > I am just guessing if that's indeed the case ;)
>> > > > Haven't done any measurements to really check if that's indeed the
>> > > > case though.
>> > > >
>> > > You don't have to do any real measurements at least on OMAP.
>> > > OCMC RAM is interfaced over L4 and MPU has to cross two interconnect
>> > > bridges to reach to SRAM. DDR is more of direct path and much faster.
>> > >
>> >
>> > Hmm, I was under the impression that OCMC RAM was on L3, at least for
>> > OMAP4.
>> > Maybe there's a extra low latency path for DDR that I am missing.
>> have you folks considered the possibility that SRAM may be
>> reprogrammed by Security code to almost nothing if PA/PPA size needs
>> to be increased? it would be rather dumb not to support HS devices on
>> which real products are made, no? rule of thumb has been to avoid
>> usage of SRAM as it constraints security folks as well (yep, I know
>> they should share code with all of us etc.. but they have a different
>> sets of challenges that may deny them such luxury).
>>
>
> Even I would like to avoid the usage of MPUSS SRAM for this very reason.
> But AFAIK the whole PPA stuff isn't applicable for OCMC RAM (not SRAM inside MPUSS).

On OMAP, even OCMC RAM can be used by security middle-ware apart from
reserved SRAM
for HS/EMU devices.
That's what Nishant meant.

Regards
Santosh
