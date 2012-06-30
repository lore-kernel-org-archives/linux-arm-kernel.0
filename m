From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sat, 30 Jun 2012 10:12:21 +0530
Subject: [PATCH v4 4/4] memory: emif: add device tree support to emif
 driver
In-Reply-To: <20120630042356.GC1816@kroah.com>
References: <1340977407-7594-1-git-send-email-santosh.shilimkar@ti.com>
 <1340977407-7594-5-git-send-email-santosh.shilimkar@ti.com>
 <CAMQu2gz6jdcR4hQPPbmyO8vrkdmppHeCkZmV3_9w27LOzKrUuA@mail.gmail.com>
 <20120630042356.GC1816@kroah.com>
Message-ID: <CAMQu2gy0MmP4JLW4P1FreJqMMEBYSTjkLHJb8WX=aXLA6hxtZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 30, 2012 at 9:53 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Sat, Jun 30, 2012 at 09:38:41AM +0530, Shilimkar, Santosh wrote:
>> (+ Greg, By mistake the your name got dropped cc from list)
>>
>> On Fri, Jun 29, 2012 at 7:13 PM, Santosh Shilimkar
>> <santosh.shilimkar@ti.com> wrote:
>> > From: Aneesh V <aneesh@ti.com>
>> >
>> > Device tree support for the EMIF driver.
>> >
>> > Reviewed-by: Benoit Cousson <b-cousson@ti.com>
>> > Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
>> > Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
>> > Signed-off-by: Aneesh V <aneesh@ti.com>
>> > [santosh.shilimkar at ti.com: Rebased against 3.5-rc]
>> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> > ---
>> > ?drivers/memory/emif.c | ?291 ++++++++++++++++++++++++++++++++++++++++++++++++-
>> > ?1 file changed, 290 insertions(+), 1 deletion(-)
>
> Wouldn't this just be better off as a separate file that only gets build
> if CONFIG_OF is set, as I'm sure that other systems are going to want
> access to these "read the device tree values" functions, right?
>
Probably yes. At least separate the LPDDR2 memory
generic parameter DT read code. There are parameters like phy
type which is specific to OMAP controllers so that still need to kept
inside EMIF driver. So there in driver, few lines of code will be there
under CONFIG_OF.

I can extract those functions which can be commonly used and put them
in another file under drivers/memory/

Is that fine with you ?

Regards
Santosh
