From: radioconfusion@gmail.com (radioconfusion at gmail.com)
Date: Thu, 07 Jul 2016 12:20:58 +0300
Subject: [crypto] [marvell-cesa] Driver hangs on Armada 385 device
Message-ID: <577e1efb.55052e0a.ec2be.3ec3@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 6 Jul 2016 09:06:55 +0200, thomas.petazzoni at free-electronics.com wrote:

> Hello,

> On Tue, 05 Jul 2016 11:46:30 +0300, radioconfusion at gmail.com wrote:

> > My Armada 385 -device hangs when using marvell-cesa -driver.
> > I'm using Linux 4.4.10 and armada-385-db-ap.dts.
> > I have also tried with the driver version of Linux 4.7-rc3.
> > 
> > Please see https://bugzilla.kernel.org/show_bug.cgi?id=120111 for details.

> Can you try with
> http://git.infradead.org/linux-mvebu.git/commitdiff/c5379ba8fccd99d5f99632c789f0393d84a57805
> applied ?

Thanks Thomas.
Your patch seems to fix a random hang during crypto operations.

Unfortunately it seems to hit the crypto performance too.
The command "cryptsetup benchmark --cipher aes-cbc"
gives me around 35 MiB/s instead of 50 MiB/s.

The patch did not fix the hanging which appears instantly after enabling tdma
in the driver and running some crypto operation.

Thanks,

Jussi
