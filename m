From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Wed, 19 Nov 2014 13:09:36 +0000
Subject: [PATCH v5.5] of/fdt: export fdt blob as /sys/firmware/fdt
In-Reply-To: <20141118221103.4ECB3C40966@trevor.secretlab.ca>
References: <1415984735-32388-1-git-send-email-ard.biesheuvel@linaro.org>
 <20141118165145.4F6A8C40966@trevor.secretlab.ca>
 <20141118172545.GC14323@leverpostej>
 <20141118221103.4ECB3C40966@trevor.secretlab.ca>
Message-ID: <1416402576.29243.35.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-11-18 at 22:11 +0000, Grant Likely wrote:
> > > * It also helps with exposing the reserved map to userspace, but kexec
> > >   has done without that feature for years, and it is in the process of
> > >   being deprecated in favour of /reserved-memory anyway.
> > 
> > This is the first I'd heard of the reserve map being deprecated, and
> > we're going to have DTs with reserved map entries for a long time going
> > forwards.
> 
> Deprecated, not removed or disabled. It will still work pretty much
> forever, but users should be encouraged to move to the reserve-memory
> tree.

I'm curious why that should be for the "OS should never touch this, here
be dragons" type memory, what are the benefits of the new scheme in that
case?

I can see it for e.g. framebuffer or cma which the OS might actually use
under special circumstances and therefore need more info than just
"don't use this".

It looks like as well as observing the requested reservations Xen might
also need to somehow reflect them to dom0, I need to think on this. If
there are any useful references over and above
Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
then I'd be glad to see them.

Ian.
