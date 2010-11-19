From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 19 Nov 2010 12:53:58 +0200
Subject: [PATCH] ARM: s3x24xx: Fix gpiochip_add complaining.
In-Reply-To: <4CE6547A.9070309@metafoo.de>
References: <1290158139-16105-1-git-send-email-marek.belisko@open-nandra.com>
	<201011191123.22255.anarsoul@gmail.com>
	<4CE6547A.9070309@metafoo.de>
Message-ID: <201011191253.58812.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 November 2010 12:42:02 Lars-Peter Clausen wrote:
> Hi
> 
> Well it actually causes problems on systems with external gpio expanders,
> because now the additional banks will take up the space which was meant
> for the gpio expander chip and peripherals connected to it wont be
> accessible.

Ok, but it would be nice to see some runtime soc-type detection for gpiolib. 
s3c2410/s3c2440/s3c2442 doesn't differ too much (actually, they're same in 
gpiopart, s3c2410 lacks some gpiobanks that s3c244[0,2] have, and difference 
in pull-up/pull-down on s3c2440 and s3c2442).
I think it's not good to make artificial restrictions for building single 
binary kernel for these socs.
 
> I sent a patch[1] about this some time ago, but I guess it was never
> applied...

Try pinging Ben or Kukjin :)

Regards
Vasily
