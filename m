From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 1 Jan 2012 23:33:35 +0100
Subject: [PATCH v2] MTD/GPMI bugfix : reset the BCH module when it is not
 MX23
In-Reply-To: <CAMiH66HsFn4+6-whEC6G-qSPda3+3pBzd50i7iHh9Pg9TXHTXw@mail.gmail.com>
References: <1325233646-3343-1-git-send-email-b32955@freescale.com>
 <20111230143658.GA9141@pengutronix.de>
 <4EFE7236.10609@freescale.com>
 <20111231154338.GA27544@pengutronix.de>
 <CAMiH66HsFn4+6-whEC6G-qSPda3+3pBzd50i7iHh9Pg9TXHTXw@mail.gmail.com>
Message-ID: <20120101223335.GA3756@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> This happens because we do NOT follow the right init procedure. The IC
> guy told me.
> If the BCH was not initialized correctly, it can not guarantees the
> data is right.
> This is why the mx28 failed.
...
> For mx23, it should not reset the BCH, this is the right init
> procedure for mx23.

Okay, this was the information I was looking for. So, the MX23 cannot be reset
due to bug #2847. But it also does not NEED to be reset, which is unlike the
MX28 which needs the reset. Correct? Before that, it was only clear that MX23
cannot be reset. It was not clear (at least to me) if it still could then run
into the same problems as the MX28 after 10000+x boot cycles. That would be a
really bad situation: being in need of the reset which we can't do due to 2847.

> But I did not ever boot 10000 times on mx23. I am not sure if it can
> fail or not.

Hmm, can't your IC guy tell you? I was hoping he knows if the same problem which
happens on the MX28 can also happen on the MX23? I don't want to make your life
unnecessarily hard, but I'd really like to know if I need to warn customers
when using MX23 and NAND (and if so, we have to update the comment in the code).

> > bug 2847, we have a serious problem, because NAND won't work until the next
> > power-cycle? I am curious if my assumptions are true and we have a serious
> > problem on the MX23.
> You can test it if you have time. :)

Testing is guessing in this case, the problem could arise after <n+1> cycles if
I tested <n>. Actually knowing the situation would be more helpful, I'd think.
If this is not possible to find out, we'd need to add this as a comment, too,
so people experiencing problems have a pointer which can save them *a lot of*
time.

Kind regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120101/c526c02f/attachment-0001.sig>
