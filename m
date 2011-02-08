From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 8 Feb 2011 16:17:58 +0100
Subject: [PATCH v2] ARM: Define wfi() macro for v6 processors
In-Reply-To: <AANLkTim90DF1pE0As_vNO-c4dn7S=2jVq+hkRo8CYsx4@mail.gmail.com>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<19a3630aad67b496a4e36354abc63c4a@mail.gmail.com>
	<AANLkTim90DF1pE0As_vNO-c4dn7S=2jVq+hkRo8CYsx4@mail.gmail.com>
Message-ID: <201102081617.59092.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 February 2011, Dave Martin wrote:
> CFLAGS_cpu_specific_object.o        += -march=armv7-a
> 
> Whether it's safe to do it depends on whether code from that file
> could ever get run on other processors.  I'm not so sure of the answer
> to that..., but perhaps someone else has a better idea.

We already do this a lot from arch/arm/mm/Makefile, and those
files are typically just one function per file, so they can easily
be proven to be safe that way.

	Arnd
