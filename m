From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 04 Jan 2011 09:32:41 -0500 (EST)
Subject: [PATCH 1/4] ARM: runtime patching of __virt_to_phys() and
	__phys_to_virt()
In-Reply-To: <20110104084517.GA9791@n2100.arm.linux.org.uk>
References: <1294129208-15201-1-git-send-email-nico@fluxnic.net>
	<1294129208-15201-2-git-send-email-nico@fluxnic.net>
	<20110104084517.GA9791@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1101040926100.22191@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Jan 2011, Russell King - ARM Linux wrote:

> This is basically my patch with a few blank lines removed, a couple
> of \n's also removed, a #error if __virt_to_phys is defined by a platform,
> a minor tweak to the assembly and it being only usable on PXA.
> 
> I much prefer my patch over this as anyone can use it.  That's one of
> the reasons why I arranged the code testing for __virt_to_phys as I
> did, so the config option could be offered without having a big long
> dependency list attached to it.

I don't think offering the option that people can turn on and not having 
the code effectively perform as expected is a good idea.  People might 
be expecting the feature to be there while in practice it is ignored 
which would lead to confusion.  Better to offer it so it can be selected 
as needed in combination with other features, such as 
CONFIG_AUTO_ZRELADDR (which in my opinion would be better hidden from 
user selection as well).

As to the authorship, since I drafted the original design, Eric Miao did 
the first implementation to validate the concept, and the code surviving 
is mostly yours, I didn't know who to singularly attribute the patch to 
in the author field.  I can put yourself there if you feel this is more 
appropriate.


Nicolas
