From: Mattis.Lorentzon@autoliv.com (Mattis Lorentzon)
Date: Wed, 13 Aug 2014 13:39:27 +0000
Subject: Oops: 17 SMP ARM (v3.16-rc2)
In-Reply-To: <CAOMZO5B8GR+ABBoJ=dJcFqw3Wagfaip7HM+C1FTz+aE4CmqiPw@mail.gmail.com>
References: <20140626151424.GT32514@n2100.arm.linux.org.uk>
 <20140627112151.GF32514@n2100.arm.linux.org.uk>
 <3FFB61A7A8473C49831AF20FA193534A43CADFA7@ALVA-EXMB01.alv.autoliv.int>
 <20140627163108.GP32514@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043575072@ALVA-EXMB04.alv.autoliv.int>
 <20140806095012.GN30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043575172@ALVA-EXMB04.alv.autoliv.int>
 <20140806125550.GO30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB804357526C@ALVA-EXMB04.alv.autoliv.int>
 <20140807121248.GY30282@n2100.arm.linux.org.uk>
 <20140808180900.GG30282@n2100.arm.linux.org.uk>
 <C4A61A5CA4AD2246942F4BA6F20ACB8043576356@ALVA-EXMB04.alv.autoliv.int>
 <CAOMZO5B8GR+ABBoJ=dJcFqw3Wagfaip7HM+C1FTz+aE4CmqiPw@mail.gmail.com>
Message-ID: <C4A61A5CA4AD2246942F4BA6F20ACB80435774FD@ALVA-EXMB04.alv.autoliv.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio and Russell,

> In order to try to narrow down whether this is a board issue, could you try to
> run the same kernel on a mx6q development board, such as mx6qsabresd,
> cubox-i, wandboard, etc?

Indeed, we have a Sabrelite development board and have run the same kernel
configuration (please find attached). Russells 30 FEC related patches are applied.
We have also tried with and without the extended interrupts entry in the DT.

All our tests seem to behave the same way on the Sabrelite as on our own board.
A working theory is that the switch (3Com Switch 4400) triggers the degeneration
of the network stack from which Linux does not seem to recover, even if we later
bypass the switch and directly connect the board to the server machine.

Since the problem is stochastic in nature we are not completely sure if we can
trigger the problem without the switch. It's the switch that allows us to run many
cards simultaneously and thus trigger the problem more easily. :-)

What are your thoughts?

Best regards,
Mattis Lorentzon

***************************************************************
Consider the environment before printing this message.

To read Autoliv's Information and Confidentiality Notice, follow this link:
http://www.autoliv.com/disclaimer.html
***************************************************************
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config.gz
Type: application/x-gzip
Size: 14775 bytes
Desc: config.gz
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140813/f7f2884e/attachment.bin>
