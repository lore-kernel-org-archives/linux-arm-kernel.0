From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Feb 2016 17:58:46 +0100
Subject: [PATCH v2] ARM: atags_to_fdt: don't warn about stack size
In-Reply-To: <7301172.5fH67MHlU9@wuerfel>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <alpine.LFD.2.20.1602181112310.13632@knanqh.ubzr>
 <7301172.5fH67MHlU9@wuerfel>
Message-ID: <8232115.18ykgQ6J5T@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 February 2016 17:26:56 Arnd Bergmann wrote:
> On Thursday 18 February 2016 11:13:52 Nicolas Pitre wrote:
> > What about setting the warning to 2048 instead?
> 
> Sure, actually 1280 is more than enough I think.
> 
It turns out that doesn't fix the problem though, as the new
argument gets prepended and the existing flag overrides it.

I have modified the patch now to do both:

CFLAGS_REMOVE_atags_to_fdt.o += -Wframe-larger-than=${CONFIG_FRAME_WARN}
CFLAGS_atags_to_fdt.o += -Wframe-larger-than=1280

	Arnd
