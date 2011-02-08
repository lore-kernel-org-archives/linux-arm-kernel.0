From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 8 Feb 2011 13:53:20 +0100
Subject: [PATCH v2] ARM: Define wfi() macro for v6 processors
In-Reply-To: <20110208121334.GB22877@n2100.arm.linux.org.uk>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<201102081311.52004.arnd@arndb.de>
	<20110208121334.GB22877@n2100.arm.linux.org.uk>
Message-ID: <201102081353.20390.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 February 2011, Russell King - ARM Linux wrote:
> > I don't see any users of the sev/wfe/wfi macros in the current kernel,
> > so removing them seems like a good strategy to avoid people from
> > using them incorrectly.
> 
> That's because they've only just been added.  See the massive 63-patch set
> from Viresh which has been posting to this mailing list.

Ok, I see. At least that version seems ok because the code is cpu
specific already.

The omap do_wfi macro is specifically meant to avoid the multi-cpu
case by using the hexadecimal notation, so it can still be used while
building a kernel for ARMv6 or lower. Dave's version seems to have
the opposite intention here (choosing one version per arch level),
so it wouldn't be a replacement.

	Arnd
