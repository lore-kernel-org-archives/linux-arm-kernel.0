From: n-chalhoub@ti.com (Chalhoub, Nicole)
Date: Wed, 9 Nov 2011 18:06:41 +0000
Subject: [PATCH] CPUIdle: Reevaluate C-states under CPU load to favor
 deeper C-states
In-Reply-To: <4EBA6046.2060305@linux.vnet.ibm.com>
References: <1316475315-5905-1-git-send-email-khilman@ti.com>
 <87d3d75zo6.fsf@ti.com> <4EBA6046.2060305@linux.vnet.ibm.com>
Message-ID: <37CAE120BAE10B42A790DD1418C8021D0136C7@DNCE02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Deepthi,

>
Texas Instruments France SA, 821 Avenue Jack Kilby, 06270 Villeneuve Loubet. 036 420 040 R.C.S Antibes. Capital de EUR 753.920

-----Original Message-----
> From: Deepthi Dharwar [mailto:deepthi at linux.vnet.ibm.com]
> Sent: Wednesday, November 09, 2011 12:13 PM
> To: Hilman, Kevin
> Cc: linux-kernel at vger.kernel.org; Arjan van de Ven; linux-arm-
> kernel at lists.infradead.org; linux-omap at vger.kernel.org; linux-
> pm at lists.linux-foundation.org; Chalhoub, Nicole
> Subject: Re: [PATCH] CPUIdle: Reevaluate C-states under CPU load to favor
> deeper C-states

[...]
> By setting timers when we enter non-deepest C-state possible, such that
> when it fires we
> can re-evaluate and try moving into deeper and deeper C-states enhancing
> the
> power savings is a good feature to have.
>
> Looking at the current implementation, is it possible to have it as
> configurable option
> where one can enable/disable this functionality through the backhand
> driver ?

The timeout values of the c state timers are set in the backhand driver.
By setting the timeout to 0 the timers will not fire so you'll not have this functionality enabled

> Also I am thinking, instead of having them in governor
> wouldnt it be a good idea to have it implemented in
> the backhand driver itself ?
> --Deepthi


In fact each C-state had its own configurable timer, so it is a parameter characterizing a C-state as it is for the exit_latency and target_residency parameters.
And we wanted the timer to fire only when we do not go in deep Cstate due to a high load. This decision is made in the CPU idle governor. So the functionality should be seen from the governor..

Thanks and Regards
Nicole
