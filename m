From: lcs0208@gmail.com (Chuansheng Liu)
Date: Thu, 15 Nov 2012 18:52:36 +0800
Subject: [PATCH 1/7] I2c-nomadik: Fix the usage of
 wait_for_completion_timeout
In-Reply-To: <20121115095741.GA6280@bnru10>
References: <1352222317.15558.1584.camel@cliu38-desktop-build>
 <CACRpkdYekQF5111NSNSPeaHdxgS_gpXkCjqT1n-n1_iAdDXbSg@mail.gmail.com>
 <20121115084858.GA29668@bnru10> <20121115092953.GA418@pengutronix.de>
 <20121115095741.GA6280@bnru10>
Message-ID: <C53EED5A-0C30-44EE-ADD5-6CBABFA3A0FE@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

timeout is never < 0, so status = timeout is never getting run. This patch delete pointless
code. Could you show the regression? Thanks.

? 2012-11-15?17:57?Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> ???

> On Thu, Nov 15, 2012 at 10:29:53 +0100, Wolfram Sang wrote:
>> 
>>>> -       if (timeout < 0) {
>>>> -               dev_err(&dev->adev->dev,
>>>> -                       "wait_for_completion_timeout "
>>>> -                       "returned %d waiting for event\n", timeout);
>>>> -               status = timeout;
>>>> -       }
>>>> -
>>> No, it is wrong. You need to update the status variable in the case of timeout.
>> 
>> Looking at the patch context, such code comes later.
> But it causes regressions; without looking at the "later" code, we can't afford merging
> this code now.
> 
> regards/srinidhi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121115/0f1d0c0f/attachment-0001.html>
