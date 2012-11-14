From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 14 Nov 2012 12:03:35 +0100
Subject: [PATCH] i2c: omap: Move the remove constraint
In-Reply-To: <20121114105734.GE5954@pengutronix.de>
References: <1352195673-31559-1-git-send-email-shubhrajyoti@ti.com>
 <CAORVsuW_VAiemnauUs-yW+GcQpv+qpESP4kzyQm=Unmofa4k_Q@mail.gmail.com>
 <20121114105734.GE5954@pengutronix.de>
Message-ID: <CAORVsuUxA=AhPowWqTWx5AfzU6R2Ny6OEhvDmtwUh8poh=UnGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram, Shubhrajyoti,

On Wed, Nov 14, 2012 at 11:57 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>
>> > Currently we just queue the transfer and release the
>> > qos constraints, however we donot wait for the transfer
>> > to complete to release the constraint. Move the remove
>> > constraint after the bus busy as we are sure that the
>> > transfers are completed by then.
>> >
>> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>>
>> Good catch, the change definitely makes sense. Feel free to add:
>>
>> Acked-by: Jean Pihet <j-pihet@ti.com>
>
> Since I just reverted the QoS patch, I suppose this gets merged into the
> original patch when resent?
The best for now is to re-submit a new patch that moves the constraint
release in the original code. Later the PM QoS patch will be applied
on the new code base.

What do you think? I can provide a patch if needed.

Regards,
Jean

>
> --
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
