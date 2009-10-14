From: peter@peter-teichmann.de (Peter Teichmann)
Date: Wed, 14 Oct 2009 20:21:58 +0200
Subject: [PATCH 4/6] ARM: remove references to non-existent fastfpe
In-Reply-To: <4AD048A4.1070805@tuffmail.co.uk>
References: <1255096942-10451-1-git-send-email-alan-jenkins@tuffmail.co.uk>
	<20091009165513.GA5902@n2100.arm.linux.org.uk>
	<4AD048A4.1070805@tuffmail.co.uk>
Message-ID: <200910142021.59118.peter@peter-teichmann.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Saturday 10 October 2009 10:41:08 schrieb Alan Jenkins:
> Russell King - ARM Linux wrote:
> > On Fri, Oct 09, 2009 at 03:02:20PM +0100, Alan Jenkins wrote:
> >> 	# Do we have FASTFPE?
> >> 	FASTFPE		:=arch/arm/fastfpe
> >> 	ifeq ($(FASTFPE),$(wildcard $(FASTFPE)))
> >> 	FASTFPE_OBJ	:=$(FASTFPE)/
> >> 	endif
> >> 	fastfpe
> >>
> >> We don't have FASTFPE.  If this code still exists out of tree, it can
> >> surely maintain its own Makefile and Kconfig entries.  Let's not
> >> confuse users by allowing them to select FASTFPE, and then silently not
> >> building it.
> >
> > The code is not maintained anymore, but can just be slotted in (as per
> > the recent request on the mailing list.)  I'd rather not have the
> > hastle of maintaining fastfpe patches thank you.
>
> Urk. The fine balancing act of limbo. Another possibility would be to
> provide a stub
>
> #error "fastfpe not included; disable it or download it"
>
> But if you want to just leave it, that's obviously your decision to make.

I agree to Alan. It seems reasonable at least to include a stub as he 
suggests. However, since FastFPE was not updated for some years now, maybe 
the burden of maintaining patches is not so heavy in anymore? Maybe we can 
as well just include the latest version now? It becomes more and more 
difficult to find the source for someone who is interested in it.

What do you think?

Peter
