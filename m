From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Apr 2011 22:58:46 +0100
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <20110420164315.6cdbcbf0@lxorguk.ukuu.org.uk>
References: <92FFDB9F-37F1-4618-A53D-FEF4151A4953@niasdigital.com>
	<20110418132629.12d9a106@lxorguk.ukuu.org.uk>
	<6C3F739A-A157-4796-9572-C6B0FAC2565E@niasdigital.com>
	<20110419093855.36910400@lxorguk.ukuu.org.uk>
	<BANLkTimqpP2k1tBvRL0BXs9E-Q=3bh0C7Q@mail.gmail.com>
	<BANLkTint6DGgosVkjK-sveyA9SL9WVS4Mg@mail.gmail.com>
	<BANLkTinaOk4Qq+uwdZQtapncwjpdTg9wmQ@mail.gmail.com>
	<20110420162958.09286aa7@lxorguk.ukuu.org.uk>
	<BANLkTi=QGoaNvJNM6SNsEduVa958bcLC1A@mail.gmail.com>
	<20110420164315.6cdbcbf0@lxorguk.ukuu.org.uk>
Message-ID: <20110427215846.GF17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 04:43:15PM +0100, Alan Cox wrote:
> > Then of course the GPIO driver can in turn call the padmux
> > subsystem to request its pins or fail/bail out if they are taken.
> 
> Yes that makes a lot more sense. It preserves the abstraction in the
> simple cases but handles the complex stuff right.

If one GPIO can be routed to multiple pads, it is not possible for
the GPIO driver to request the padmux code to route the GPIO to the
outside world - the GPIO layer doesn't have the information to tell
the padmux code which pad to route the GPIO to.
