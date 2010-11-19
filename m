From: linus.walleij@stericsson.com (Linus WALLEIJ)
Date: Fri, 19 Nov 2010 22:49:50 +0100
Subject: [PATCH] ARM: l2x0: Check the correct address range
In-Reply-To: <AANLkTinqvbPB5ijJnMGB1FP08WUMSUKFY_qZhgZaVUci@mail.gmail.com>
References: <20101119014029.GA26429@july>
	<AANLkTinqvbPB5ijJnMGB1FP08WUMSUKFY_qZhgZaVUci@mail.gmail.com>
Message-ID: <CEE6BB42CAD6E947908279175AF8470A074DE04727@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-11-19 at 11:08 +0000, Catalin Marinas wrote:
> On 19 November 2010 01:40, Kyungmin Park <kmpark@infradead.org> wrote:
> > From: Boojin Kim <boojin.kim@samsung.com>
> >
> > When flush or clean the 1MiB, it doesn't flush or clean all since it doesn't check the correct address. So Check the correct address range.
> 
> This line is very long.
> 
> The patch looks fine otherwise. I think the optimal value would be
> smaller than the whole cache size but it depends on many things.

Would it be a good idea to kick in a per-SoC threshold value into
the l2x0 range clean function, such that if the range exceed this
specific threshold it cleans all of it? That way it'd be possible
to optimize for each SoC quite easily.

I've heard that these things may even depend on OPPs etc so it may
even be some dynamic value...

Yours,
Linus Walleij
-------------- next part --------------
A non-text attachment was scrubbed...
Name: winmail.dat
Type: application/ms-tnef
Size: 3547 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101119/0e0c8bc6/attachment-0001.bin>
