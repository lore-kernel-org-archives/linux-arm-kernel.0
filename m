From: shubhrajyoti@ti.com (Datta, Shubhrajyoti)
Date: Tue, 10 Jan 2012 11:54:13 +0530
Subject: [PATCHv8 4/5] OMAP: I2C: Remove the reset in the init path
In-Reply-To: <CANQgH-Ze1S6sy1uhzy_b8GWOCjF4+-9DOCcUn9mq1kAaT+Y7FA@mail.gmail.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com>
 <1323773758-6375-5-git-send-email-shubhrajyoti@ti.com>
 <alpine.DEB.2.00.1112160139010.12660@utopia.booyaka.com>
 <4EEB086A.2050607@ti.com>
 <CANQgH-Ze1S6sy1uhzy_b8GWOCjF4+-9DOCcUn9mq1kAaT+Y7FA@mail.gmail.com>
Message-ID: <CANQgH-YLez8B-t8nf9_M8samn9YWUa7LcOFx6uPFrJE9tnXB1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2012 at 11:53 AM, Datta, Shubhrajyoti
<shubhrajyoti@ti.com> wrote:
>
>
>
> On Fri, Dec 16, 2011 at 2:29 PM, Shubhrajyoti <shubhrajyoti@ti.com> wrote:
>>
>> Ben,
>>
>> On Friday 16 December 2011 02:10 PM, Paul Walmsley wrote:
>> > Hi
>> >
>> > On Tue, 13 Dec 2011, Shubhrajyoti D wrote:
>> >
>> >> - ?The reset in the driver at init is not needed anymore as the
>> >> ? ?hwmod framework takes care of reseting it.
>> >> - ?Reset is removed from omap_i2c_init, which was called
>> >> ? ?not only during probe, but also after time out and error handling.
>> >> ? ?device_reset were added in those places to effect the reset.
>> >> - ?Earlier the hwmod SYSC settings were over-written in the driver.
>> >> ? ?Removing the same and letting the hwmod take care of the settings.
>> >> - ?Clean up the SYSS_RESETDONE_MASK macro as it is no longer needed.
>> >> - ?Clean up the SYSCONFIG SYSC bit definition macros.
>> >> - ?Fix the typos in wakeup.
>> >>
>> >> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> >> ---
>> >> ?drivers/i2c/busses/i2c-omap.c | ? 83 +++++++++++-----------------------------
>> >> ?1 files changed, 23 insertions(+), 60 deletions(-)
>> > This patch either needs to be acked by Ben with a note that it's okay for
>> > us to merge through the OMAP tree, or needs to be merged by Ben during the
>> > 3.4 merge window, after patches 1-3 have reached the mainline tree.
>> I agree.
>> Ben do you have any comments .
>
>
If there are no further comments can this be merged also ?
Thanks.
>
>>
>> >
>> > - Paul
>>
>
