From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 03 May 2011 15:45:48 -0400 (EDT)
Subject: [PATCH 1/2] Moving Marvell Dove platform defaults to ARMv7
In-Reply-To: <BANLkTimXLfcAsU47R+xEvU8Nq-A8NEWmOw@mail.gmail.com>
References: <1302173382-25577-1-git-send-email-kostap@marvell.com>
	<BANLkTikCBDCYr6BHz4zWPvHfuAQ+eCtvNg@mail.gmail.com>
	<alpine.LFD.2.00.1105021354410.24613@xanadu.home>
	<alpine.LFD.2.00.1105021434230.24613@xanadu.home>
	<BANLkTimdti4Cj2BMqsRdnmOB7Dtt9=QTCQ@mail.gmail.com>
	<BANLkTimXLfcAsU47R+xEvU8Nq-A8NEWmOw@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1105031542480.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 May 2011, Haojian Zhuang wrote:

> On Tue, May 3, 2011 at 7:12 PM, saeed bishara <saeed.bishara@gmail.com> wrote:
> >>
> >> BTW, does this mean that all PJ4's are ARMv7 capable now?
> > yes
> >> If so, can the PJ4 entry in arch/arm/mm/proc-v6.s be removed?
> > sure, we will prepare a patch that removes the PJ4 from that file and
> > from arch/arm/boot/compressed/head.S
> > Haojian, can you please approve?
> >
> > saeed
> >
> 
> I'm OK on this change. MMP2 (PJ4 core) is also used as ARMv7 capable.

So I did remove those entries.  That also allows for the Dove kernel to 
be compiled using Thumb2 without any additional changes.


Nicolas
