From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Tue, 20 Aug 2013 16:01:47 +0530
Subject: Kexec: BE kernel on ARM VE TC2
In-Reply-To: <CALicx6vwz9h3gKozaKxaL+FbVvfkWS5djYrt22vM0d72ObDhYw@mail.gmail.com>
References: <CALicx6ueLxCFCeun1grdtcC21HSkCDfenLWOSfuoSJnhx9GZ6w@mail.gmail.com>
 <20130808215034.GE19383@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1308131851300.14472@syhkavp.arg>
 <CALicx6uKhd0z=81G68VvTjBpPy=vwK3tgK8zk11dpu34N=YyYA@mail.gmail.com>
 <alpine.LFD.2.03.1308141026210.14472@syhkavp.arg>
 <CALicx6sgS6J4aU2mf3fBoWA7oREDrbkit4FW-ptj49EmLuH_HA@mail.gmail.com>
 <CALicx6vwz9h3gKozaKxaL+FbVvfkWS5djYrt22vM0d72ObDhYw@mail.gmail.com>
Message-ID: <CALicx6s8A5+YUm0ZD0fZS8DU37HkA_3FHF70R0XDRj2=mta4_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 5:47 PM, Vijay Kilari <vijay.kilari@gmail.com> wrote:
> Hi Nicolas,
>
> On Mon, Aug 19, 2013 at 1:01 PM, Vijay Kilari <vijay.kilari@gmail.com> wrote:
>> On Wed, Aug 14, 2013 at 8:49 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
>>> On Wed, 14 Aug 2013, Vijay Kilari wrote:
>>>
>>>> On Wed, Aug 14, 2013 at 4:22 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>>>> > On Thu, 8 Aug 2013, Will Deacon wrote:
>>>> >
>>>> >> On Mon, Aug 05, 2013 at 01:12:17PM +0100, Vijay Kilari wrote:
>>>> >> > Hi Will,
>>>> >> >
>>>> >> > I am trying to make kexec work on BE kernel on ARM VE TC2.
>>>> >> >
>>>> >> > First, to make KEXEC work with SMP on ARM VE TC2 board,
>>>> >> > I set nr_cpus=2 (i.e boot only A15's) this works with LE kernel.
>>>> >>
>>>> >> Interesting, is this with a mainline kernel? I don't see how SMP kexec can
>>>> >> work on TC2 without additional patches to park the secondary cores safely.
>>>> >
>>>> > BTW those patches are available in linux-next at the moment.
>>>>

>
> After using v5.0 firmware version + CPU migration patch and making changes to
> board.txt according to
> http://lists.linaro.org/pipermail/linaro-dev/2013-January/015095.html
>
> Now all the CPU's are booting up. I will check now Kexec
>
>

I see two issues:

1) KEXEC rebooting with Thumb2 kernel fails when booted on LE Kernel.
2) Secondary CPU's are not booted with BE kernel with TC2 Power mgmt enabled
    Where as with LE, secondary CPU's are booted

>>> Nicolas
