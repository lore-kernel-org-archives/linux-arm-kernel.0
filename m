From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 15 May 2012 16:31:43 +0300
Subject: [PATCH] MTD: LPC32xx SLC NAND driver
In-Reply-To: <4FB25837.2050603@antcom.de>
References: <1336829386-23301-1-git-send-email-stigge@antcom.de>
 <1337068543.2528.143.camel@sauron.fi.intel.com>
 <4FB2109A.2080505@freescale.com> <4FB25837.2050603@antcom.de>
Message-ID: <1337088703.2528.208.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-05-15 at 15:20 +0200, Roland Stigge wrote:
> >> while ((readl(...))&&  timeout-->  0)
> >>     cpu_relax();
> 
> As I understand loops_per_jiffy, this loop will take much longer than
> the 100 ms you defined above?

Not sure about much, but longer. The idea is that this is about the
error path so if we report -EIO with a slight delay - no problem.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120515/c143b260/attachment.sig>
