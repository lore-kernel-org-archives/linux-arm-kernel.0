From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 7 Jul 2016 15:43:14 +0200
Subject: [crypto] [marvell-cesa] Driver hangs on Armada 385 device
In-Reply-To: <577e1efb.55052e0a.ec2be.3ec3@mx.google.com>
References: <577e1efb.55052e0a.ec2be.3ec3@mx.google.com>
Message-ID: <20160707154314.241c3605@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 07 Jul 2016 12:20:58 +0300, radioconfusion at gmail.com wrote:

> > On Tue, 05 Jul 2016 11:46:30 +0300, radioconfusion at gmail.com wrote:  
> 
> > > My Armada 385 -device hangs when using marvell-cesa -driver.
> > > I'm using Linux 4.4.10 and armada-385-db-ap.dts.
> > > I have also tried with the driver version of Linux 4.7-rc3.
> > > 
> > > Please see https://bugzilla.kernel.org/show_bug.cgi?id=120111 for details.  
> 
> > Can you try with
> > http://git.infradead.org/linux-mvebu.git/commitdiff/c5379ba8fccd99d5f99632c789f0393d84a57805
> > applied ?  
> 
> Thanks Thomas.
> Your patch seems to fix a random hang during crypto operations.

OK, great.

> Unfortunately it seems to hit the crypto performance too.
> The command "cryptsetup benchmark --cipher aes-cbc"
> gives me around 35 MiB/s instead of 50 MiB/s.
> 
> The patch did not fix the hanging which appears instantly after enabling tdma
> in the driver and running some crypto operation.

I don't understand. Above you're saying that it fixes the problem, and
now you're saying that it doesn't.

Could you test with the latest 4.7-rc kernel + the patch I provided?

(i.e, don't use 4.4 + your own backports, we have no idea which patches
you have backported, and if the backport was done properly)

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
