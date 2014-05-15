From: robherring2@gmail.com (Rob Herring)
Date: Thu, 15 May 2014 09:59:31 -0500
Subject: [RFC PATCHv1 0/7] ARM core support for hardware I/O coherency in
 non-SMP platforms
In-Reply-To: <20140515142205.GC1499@arm.com>
References: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140514170456.GC15946@arm.com>
 <20140515115010.0d6a4d92@free-electrons.com>
 <20140515142205.GC1499@arm.com>
Message-ID: <CAL_JsqK80pFHQBgMxc1FGi998UYnbKxOK2gbm_ftqrTaxNq4rA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 9:22 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Thu, May 15, 2014 at 10:50:10AM +0100, Thomas Petazzoni wrote:
>> On Wed, 14 May 2014 18:04:56 +0100, Catalin Marinas wrote:
>> > On Wed, May 14, 2014 at 04:50:34PM +0100, Thomas Petazzoni wrote:
>> > > This hardware I/O coherency mechanism needs a set of ARM core
>> > > requirements to operate properly:

[...]

>> > >    - The SCU must be enabled
>> >
>> > Again, could the firmware do this?
>>
>> See above. If the kernel does it for SMP cases, why wouldn't it do it
>> also for !SMP I/O coherent cases?
>
> The I/O coherency is an SoC property rather than an ARM architecture
> property. I want to separate the two so that the kernel can boot a
> significant part assuming sane architecture settings. Once you have DT
> available and start loading device drivers, you are in the SoC realm and
> you can do whatever initialisation for buses, interconnects, but not
> going back to change architected settings.

The SCU has nothing to do with the architecture and really is part of
the SOC. Let's look at this another way. Are there any usecases where
you would not enable the SCU? If any cores are coherent or the ACP is
coherent, it must be on. So that leaves all core in AMP mode. In this
case, does it matter if the SCU is enabled or not?

Rob
