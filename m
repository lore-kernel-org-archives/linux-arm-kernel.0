From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 15 May 2015 13:13:28 +0200
Subject: [PATCH v4 0/6] SA1100/PXA RTC clean-up
In-Reply-To: <1431529350-4597-1-git-send-email-robh@kernel.org> (Rob Herring's
 message of "Wed, 13 May 2015 10:02:24 -0500")
References: <1431529350-4597-1-git-send-email-robh@kernel.org>
Message-ID: <87pp62jdpj.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

> A git branch is here[4]. I've tested sa1100-rtc on PXA1928. I need help
> testing on PXA27x/3xx.
Hi Rob,

I tested on PXA27x. It works for the boards which used pxa-rtc.
For the others, their defconfig become broken, because the pxa boards with
sa1100-rtc do not work anymore. And of course no .config manipulation will fix
this, because PXA architecture is denied the sa1100-rtc driver.

As a consequence, these boards should transition from sa1100-rtc to pxa-rtc to
get back a working rtc, amongst which :
	cm_x2xx_defconfig
	em_x270_defconfig
	h5000_defconfig
	jornada720_defconfig
	magician_defconfig
	palmz72_defconfig
	pcm027_defconfig
	trizeps4_defconfig
	viper_defconfig
	xcep_defconfig

I think you should at least Cc the maintainers of these boards to see their
reaction. They should be aware of the impacts and comment.

I'll make a test for pxa3xx in the next week.

Cheers.

--
Robert
