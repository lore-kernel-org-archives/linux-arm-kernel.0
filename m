From: robherring2@gmail.com (Rob Herring)
Date: Thu, 6 Mar 2014 02:20:32 -0600
Subject: [PATCH 5/5] arm64: add early_ioremap support
In-Reply-To: <1394037524.5094.35.camel@deneb.redhat.com>
References: <1393963738-9210-1-git-send-email-msalter@redhat.com>
 <1393963738-9210-6-git-send-email-msalter@redhat.com>
 <CAL_JsqLQ8gj4nkwh+67i58rQBARoh_CgZ+4D9uepdBQm-XBwJA@mail.gmail.com>
 <1394037524.5094.35.camel@deneb.redhat.com>
Message-ID: <CAL_JsqLSTMp4_OREGdGtah31HZmmMAgqi3eb3NZgM04dfqZNMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 5, 2014 at 10:38 AM, Mark Salter <msalter@redhat.com> wrote:
> On Tue, 2014-03-04 at 17:31 -0600, Rob Herring wrote:
>> On Tue, Mar 4, 2014 at 2:08 PM, Mark Salter <msalter@redhat.com> wrote:
>> > Add support for early IO or memory mappings which are needed
>> > before the normal ioremap() is usable. This also adds fixmap
>> > support for permanent fixed mappings such as that used by the
>> > earlyprintk device register region.
>>
>> One minor comment:
>>
>> > +enum fixed_addresses {
>> > +       FIX_EARLYCON,
>>
>> Can you align this name with x86 and rename to FIX_EARLYCON_MEM_BASE.
>> Doing that will help enable the earlycon driver in 8250_early.c.
>
> Is there any advantage to earlycon=uart8250 vs. earlyprintk=uart8250?

Functionally, they are pretty much the same. I'm working on a series
to generalize earlycon and then we will be able to delete
early_printk.c from arm64 and ultimately share with arm. Doing this
alignment just saves a patch to change it later.

> I don't mind using FIX_EARLYCON_MEM_BASE, but CONFIG_FIX_EARLYCON_MEM
> is X86 only right now and I think changing that should be a separate
> patch.

Yes, definitely.

Rob
