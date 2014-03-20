From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Thu, 20 Mar 2014 10:58:31 -0400
Subject: [RFC] PSCI: Use DT Function ID values only for old versions of
 spec
In-Reply-To: <20140320143533.GE23372@e106331-lin.cambridge.arm.com>
References: <1394772816-8078-1-git-send-email-ashwin.chaugule@linaro.org>
 <20140314095246.GH25870@e106331-lin.cambridge.arm.com>
 <CAJ5Y-eZMWr0rGZnEXo3N0+aLAMLaYqA3-GCDT6oNcqZtBMxNFQ@mail.gmail.com>
 <CAJ5Y-eYBLS7pDhWoFov2djs9Ld_i9y0bW2nWzS+Q=9z4wFudOA@mail.gmail.com>
 <20140320143533.GE23372@e106331-lin.cambridge.arm.com>
Message-ID: <CAJ5Y-ebQy67Jpv9pj-raP+L33h=e9Hu0p89SdpteDGuP7D4CGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,


On 20 March 2014 10:35, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Mar 20, 2014 at 02:03:22AM +0000, Ashwin Chaugule wrote:
>> Hi Mark,
>>
>> > On 14 March 2014 05:52, Mark Rutland <mark.rutland@arm.com> wrote:
>> >>
>> >> > +     psci_function_id[PSCI_FN_MIGRATE] = PSCI_ID_CPU_MIGRATE;
>> >> > +     psci_ops.migrate = psci_migrate;
>> >>
>> >> It would also be a good idea to hook up AFFINITY_INFO to a cpu_kill
>> >> callback from the start, to ensure implementors bother to implement it,
>> >> and such that we can make kexec safe(r).
>> >>
>> >> If we rely on it from the start it's more likely that it will actually
>> >> get implemented, and it will highlight any dodgy PSCI 0.2
>> >> implementations while there's a chance they can be fixed.
>> >>
>> >
>>
>> Although I sent v1 of this patch, I haven't forgotten about this part.
>> Had a go at it, but it turned out quite messy for ARM32. I was trying
>> to get cpu_kill via smp_ops.
>
> I'm not sure I follow. Do you have an example patch or tree that would
> highlight the difficulty?

Perhaps I didnt follow. ;)
Are you suggesting something like this:

psci_ops.affinity_info = psci_cpu_off;


Cheers,
Ashwin
