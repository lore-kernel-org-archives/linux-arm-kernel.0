From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 19 Oct 2009 14:11:10 +0200
Subject: kirkwood pci support
In-Reply-To: <874opzthye.fsf@lechat.rtp-net.org> (Arnaud Patard's message of
	"Fri\, 16 Oct 2009 18\:35\:37 +0200")
References: <874opzthye.fsf@lechat.rtp-net.org>
Message-ID: <87aaznshwh.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org> writes:

Hi,

[replying to self ]

> Hi,
>
> I've been playing with an OpenRD-client machine and tried to get working
> a more recent kernel than the default 2.6.22. Unfortunately, looks like
> there's some issues with the PCI support. The machine has a XGI Z11
> card and the xgi framebuffer driver has not been able to initialise
> the card.
> After some debugging I've made the patch I'm joining to this mail.
>>From what I understand, the pci i/o port stuff is configured to use the
> default address (arch/arm/mach-kirkwood/pcie.c:kirkwood_pcie_setup) and
> when initilizing the memory windows, it's remapping the i/o port address
> to 0 (arch/arm/mach-kirkwood/addr-map.c:kirkwood_setup_cpu_mbus). If I
> remove the mapping, the framebuffer driver is sort-of working. I've
> something on the screen but it's garbled.
> As I don't have a lot of confidence in the framebuffer driver, I don't
> know if the problem comes from the driver or from an other bug in the
> pci support for the kirkwood :(

It turns out that it was a bug in the framebuffer driver. I used the
version available at :
http://groups.google.com/group/openrd/browse_thread/thread/9432b69171a15629#
with my patch and now I've the fb console and X (using the fbdev
driver not xgi driver).

Arnaud
