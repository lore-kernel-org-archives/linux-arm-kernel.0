From: sf84@laposte.net (Sebastian Frias)
Date: Mon, 12 Sep 2016 14:29:37 +0200
Subject: ARM, SoC: About the use DT-defined properties by 3rd-party drivers
In-Reply-To: <CAOZdJXVjsR3NTWiJX33yT3jYk=FU65raWoMooTLD7OMN3sqP-A@mail.gmail.com>
References: <57BDAF2E.10502@laposte.net>
 <CAOZdJXVjsR3NTWiJX33yT3jYk=FU65raWoMooTLD7OMN3sqP-A@mail.gmail.com>
Message-ID: <57D69FB1.2020801@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Timur,

On 08/28/2016 10:36 PM, Timur Tabi wrote:
> On Wed, Aug 24, 2016 at 9:29 AM, Sebastian Frias <sf84@laposte.net> wrote:
>>
>> If this is really not possible, it forces the SoC manufacturer to expose
>> those properties in a different way, thus wasting a (seemingly) perfectly
>> fine way of doing so: the DT and its documentation.
> 
> When you submit a new driver upstream, that patch also includes the
> new device tree nodes and documentation for those nodes.  Everything
> is peer-reviewed together.  I don't understand what you think the
> problem is.
> 

Thanks for your comment and sorry for the late reply.

My question is about submitting DT properties/nodes (describing some HW) for
which there is no Linux driver. Like register addresses for HW blocks,
including HW capabilities of said HW blocks, which may or may not be setup
by Linux directly.

The idea being that since DT describes the HW and is usually shared with the
bootloader (yet stored in the Linux kernel tree), all layers of the stack
could use the same DT and each layer would use relevant properties. So the
DT would describe the whole SoC even if not all HW blocks have a Linux
driver.

3rd party users of said SoC could then write kernel modules for such HW
blocks using the DT description. The DT would thus become the authoritative
source of information regarding register programming for the SoC.

Currently, HW blocks for which there is no public driver (that it is
accessed through user-mode libraries or firmware) require a separate
HW description (be it Documentation, headers, etc.)

Since the DT describes the HW, it would make sense to expose the HW through
DT, that would centralise the HW description.

However, after discussing over IRC, it looks like there was no guidance on
this. Some people think submitting DT properties/nodes without a corresponding
Linux driver is frowned upon, while others thought it was an odd limitation
and suggested asking here.

Does that clarifies the scope of the question?

Best regards,

Sebastian
