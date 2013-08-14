From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Wed, 14 Aug 2013 11:16:35 +0530
Subject: Kexec: BE kernel on ARM VE TC2
In-Reply-To: <alpine.LFD.2.03.1308131851300.14472@syhkavp.arg>
References: <CALicx6ueLxCFCeun1grdtcC21HSkCDfenLWOSfuoSJnhx9GZ6w@mail.gmail.com>
 <20130808215034.GE19383@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1308131851300.14472@syhkavp.arg>
Message-ID: <CALicx6uKhd0z=81G68VvTjBpPy=vwK3tgK8zk11dpu34N=YyYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 4:22 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Thu, 8 Aug 2013, Will Deacon wrote:
>
>> On Mon, Aug 05, 2013 at 01:12:17PM +0100, Vijay Kilari wrote:
>> > Hi Will,
>> >
>> > I am trying to make kexec work on BE kernel on ARM VE TC2.
>> >
>> > First, to make KEXEC work with SMP on ARM VE TC2 board,
>> > I set nr_cpus=2 (i.e boot only A15's) this works with LE kernel.
>>
>> Interesting, is this with a mainline kernel? I don't see how SMP kexec can
>> work on TC2 without additional patches to park the secondary cores safely.
>
> BTW those patches are available in linux-next at the moment.

Thanks for this info.
I see that MCPM, TC2_PM & SPC configuration needs to be enabled to have
TC2 power management. However MCPM also depends on CCI configuration
to register smps ops.
In my config, I dont have CCI config enabled

Can you please suggest right configuration to be enabled and also dts
configuration
for SPC, CCI to enable TC2 power mgmt.

Also I am using u-boot. Do I need to use UEFI/firmware to enable TC2 power mgmt?
I remember, some time back, I have tried linaro tracking git and
failed to boot my board
>
>
> Nicolas
