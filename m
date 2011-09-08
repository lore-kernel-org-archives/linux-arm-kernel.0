From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 08 Sep 2011 16:33:00 -0400 (EDT)
Subject: [RFC] Kbuild: allow code re-use across different directories
In-Reply-To: <CACqU3MXcksYxdV_=OR40fPeZzu1ygr-Qs79TV6kfn0DpbXhjuA@mail.gmail.com>
References: <1313800642-32418-1-git-send-email-lacombar@gmail.com>
	<alpine.LFD.2.00.1109071437400.20358@xanadu.home>
	<CACqU3MVF8XSdKi0PeZF5SFaH9i2HPqCjkMqccyb83x4V_1Vs1g@mail.gmail.com>
	<alpine.LFD.2.00.1109071554480.20358@xanadu.home>
	<CACqU3MXcksYxdV_=OR40fPeZzu1ygr-Qs79TV6kfn0DpbXhjuA@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1109081617440.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Sep 2011, Arnaud Lacombe wrote:

> you missed:
> 
>  # Make sure files are removed during clean
> -extra-y       += piggy.gzip piggy.lzo piggy.lzma lib1funcs.S
> +extra-y       += piggy.gzip piggy.lzo piggy.lzma
> 
> This confused make.

Well... that was suttle.

So yes, your patch may certainly be useful to a couple cases, and it 
works fine for this lib1func.S.

It doesn't help me much in the following situation though.  What I 
actually want to achieve is to compile arch/arm/boot/compressed/fdt_rw.o 
from scripts/dtc/libfdt/fdt_rw.c, however I want it to include my local 
version of libfdt_env.h rather than scripts/dtc/libfdt/libfdt_env.h.  I 
still haven't found a way to convince gcc to do that.


Nicolas
