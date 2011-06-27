From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 27 Jun 2011 16:36:26 -0700
Subject: [PATCH 4/8] OMAP2+: PM: idle clkdms only if already in idle
In-Reply-To: <alpine.DEB.2.00.1106270012410.460@utopia.booyaka.com>
References: <1307616853-28395-1-git-send-email-rnayak@ti.com>
	<1307616853-28395-2-git-send-email-rnayak@ti.com>
	<1307616853-28395-3-git-send-email-rnayak@ti.com>
	<1307616853-28395-4-git-send-email-rnayak@ti.com>
	<1307616853-28395-5-git-send-email-rnayak@ti.com>
	<20110610001556.GA9159@google.com> <4DF1FE6A.3010202@ti.com>
	<alpine.DEB.2.00.1106270012410.460@utopia.booyaka.com>
Message-ID: <4E0913FA.9030607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 6/26/2011 11:34 PM, Paul Walmsley wrote:
> Hi Rajendra, Todd,
>
> On Fri, 10 Jun 2011, Rajendra Nayak wrote:
>
>> Paul/Benoit any thoughts on if a per-clkdm lock seems reasonable?
>
> Sounds okay to me.
>
> The experimental patch that you sent didn't add the locking to the *wkdep,
> *sleepdep functions; I guess we'd better add it there at the same time,
> since some of the register access there does a read-modify-write.

My initial idea was to just guard the functions which program the
target clockdomain state, since that's something which had a possibility
of racing.
For the sleepdep/wkupdep programming, I thought they are all done from
within frameworks and during pm-core init at boot and might not run into
concurrency issues. But maybe it makes sense to guard those as well.

>
> It should be possible to get rid of the atomic_t usage in the clockdomain
> code as part of the same series.

Sure, I'll get rid of those.

Thanks,
Rajendra

>
> Todd, thanks for pointing this out.
>
>
> - Paul
