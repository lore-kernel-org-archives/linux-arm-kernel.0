From: sachinikam@gmail.com (Sachin Nikam)
Date: Mon, 11 Apr 2011 14:37:32 +0530
Subject: [PATCH v2 00/12] mmc: use nonblock mmc requests to minimize
	latency
In-Reply-To: <BANLkTikoj6UTx08ntZaMM15taKRXjrU_Mg@mail.gmail.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<BANLkTikZVDejarZ4O5KgNS7S4fxBLSmANA@mail.gmail.com>
	<BANLkTikVeXvfSBS-xLDXVdesKJpKdtUVqg@mail.gmail.com>
	<BANLkTikwCveocjPdoMoLEVpNneKkq66s4g@mail.gmail.com>
	<BANLkTikoj6UTx08ntZaMM15taKRXjrU_Mg@mail.gmail.com>
Message-ID: <BANLkTimJdTG+1LD2+hN8SC9-YsbRZ4jBZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Does anybody knows which kernel version will have support for SD4.0 specs
UHS-2?


On Mon, Apr 11, 2011 at 2:33 PM, Per Forlin <per.forlin@linaro.org> wrote:

> On 10 April 2011 05:33, anish singh <anish198519851985@gmail.com> wrote:
> >
> >
> > On Sat, Apr 9, 2011 at 5:25 PM, Jae hoon Chung <jh80.chung@gmail.com>
> wrote:
> >>
> >> Hi Per..
> >>
> >> I'm applied your patch..and sent the patch about dw_mmc.c.
> >> I think good this approach..
> >
> > Forlin,i too want to test this patch of yours but unfortunately i have
> > samsung board+SDHCI host controller so i guess i just need to write
> pre_req
> > and post_req functions and that would enable this(nonblock mmc request)
> on
> > my board.Hope i am right?
> You are right. The  SDHCI driver should work just fine without
> implementing pre_req and post_req but you wont see any performance
> increasing for DMA usage.
> In order to benefit from the patchset you need to implement pre_req
> and post_req.
>
> If you run into trouble implementing those hooks or if you have any
> questions please let me know.
>
> Regards,
> Per
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Have a nice time !!!

Cheers,
Sachin.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110411/0069f08d/attachment-0001.html>
