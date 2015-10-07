From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Oct 2015 10:44:13 +0100
Subject: [PATCH v2] ARM: dts: sunxi: Add regulators for LeMaker BananaPi
In-Reply-To: <20151005173957.B1BD16C8150E@dd34104.kasserver.com>
References: <1438532305-5884-1-git-send-email-public_timo.s@silentcreek.de>
 <20150818153631.GH2547@lukather>
 <CAMAWPa-Q7o+Ys2FjhLZt6Nwq=Ja6TTdWFDZFTCYLkoLGjpLpxw@mail.gmail.com>
 <20151005173957.B1BD16C8150E@dd34104.kasserver.com>
Message-ID: <20151007094413.GC2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Timo,

On Mon, Oct 05, 2015 at 07:39:57PM +0200, Timo Sigurdsson wrote:
> Hi Kevin,
> 
> Kevin Hilman schrieb am 24.09.2015 19:57:
> > kernelci.org started finding boot faiulres[1] on bananapi linux-next
> > around next-20150918, but it was only failing in some labs and not
> > others.  I finally bisected it down to this patch, which landed in
> > linux-next in the form of 2d665a8a8350 ARM: dts: sunxi: Add regulators
> > for LeMaker BananaPi.  Reverting that commit on top of next-20150923
> > gets my bananapi booting again.
> > 
> > Note it's kind of an interesting boot failure.  The kernel boots fully
> > to a shell, but panics after running a few commands.  In particular
> > 'dmesg -n1' seems to trigger it usually[2].
> > 
> > Kevin
> > 
> > [1]
> > http://kernelci.org/boot/sun7i-a20-bananapi/job/next/kernel/next-20150923/defconfig/multi_v7_defconfig/lab/lab-khilman/?_id=5602504359b514be146c326f
> > [2]
> > http://storage.kernelci.org/next/next-20150923/arm-multi_v7_defconfig/lab-khilman/boot-sun7i-a20-bananapi.html
> 
> following up on my last email: I'm back from my vacation and I tried to
> reproduce your problem, but my board doesn't seem to be affected, so I
> cannot trigger it.

weird.

> I still think that the lower voltages may be the cause of your problem
> with that specific board, so could you please test the attached patch on
> top of my patch that you first experienced the problem with? Please let 
> us know whether this solves your issue or whether we need to dig deeper.
> 
> Has anybody else been able to reproduce Kevin's issue?

I've talked to Kevin yesterday about that issue, and he's been away
from his boards for quite some time too, so we'll have to wait a bit
to solve that issue.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151007/09d60936/attachment-0001.sig>
