From: johannes.pointner@gmail.com (Johannes Pointner)
Date: Fri, 21 Nov 2014 16:11:02 +0100
Subject: [PATCH v4 3/6] mfd: ti_am335x_tscadc: Remove unwanted
 reg_se_cache save
In-Reply-To: <20141121131036.GA18931@localhost.localdomain>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
 <1415941651-28962-4-git-send-email-vigneshr@ti.com>
 <20141118143005.GF24004@x1> <20141118171240.GB3003@dtor-ws>
 <546DF2F0.9080405@ti.com>
 <20141120144028.GB5809@localhost.localdomain>
 <546F2BA4.4000808@ti.com>
 <20141121131036.GA18931@localhost.localdomain>
Message-ID: <CAJKbBDDVTA+=priRu7sCD=vHrC8AUg4DM3kycuGrqbpF-5FGAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I tested version 4 of the patch series on a custom design and I saw
also the jumps as described by Richard. I played a little with the
sample delay and it got better but I couldn't completely remove the
jumps.
The other issue I had with version 3, the pen_ups during the busy
loop, is solved. I experienced some pen_up misses during the busy loop
if I used a too high sample delay, without the sample delay it was ok.

Thanks,
Hannes

2014-11-21 14:10 GMT+01:00 Richard Cochran <richardcochran@gmail.com>:
> On Fri, Nov 21, 2014 at 05:40:12PM +0530, Sekhar Nori wrote:
>> Not sure how to reproduce the jumping on pen-up.
>
> Does the cursor stay in exactly the same spot when you lift up the
> stylus? Then you don't have the issue.
>
> On the BB white using the LCD4 cape and the shipped debian kernel, the
> cursor *does* jump away, but not as often or as far as on the custom
> design I was working with.
>
> Thanks,
> Richard
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
