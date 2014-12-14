From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 14 Dec 2014 17:29:25 +0100
Subject: [PATCH v2 1/4] pci: iProc: define Broadcom iProc PCIe binding
In-Reply-To: <548D5CD1.10801@broadcom.com>
References: <1418351817-14898-2-git-send-email-rjui@broadcom.com>
 <3383252.Ad6Qf0H2fa@wuerfel> <548D5CD1.10801@broadcom.com>
Message-ID: <3622321.f8bfUffhzH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 14 December 2014 10:48:01 Arend van Spriel wrote:
> On 12/13/14 20:46, Arnd Bergmann wrote:
> > On Saturday 13 December 2014 11:05:52 Arend van Spriel wrote:
> >>
> >> Makes sense. I think that is what Hauke meant by "adding
> >> additional support for registering to bcma". So the discovery info is a
> >> piece of read-only memory in the chip. Its address is stored in the
> >> chipcommon core register space. BCMA parses that memory blob resulting
> >> in a list of cores which register address info. We could add DT support
> >> in BCMA matching the compatible string and register a core for it.
> >
> > Ah, interesting idea. That would mirror what we do for drivers/amba,
> > I like the idea.
> 
> + Rafal
> 
> Let's explore this. Although I don't have the iProc hardware to verify it.
> 

If we can make this work nicely, you won't even need iProc hardware,
but instead provide all the data for the bcma devices on an older
machine through DT and get the probing to work with that. For AMBA,
we actually allow mixing amba and platform devices on the same parent.
You could do this here as well, but it would be simpler to have a
a special bcma device node as the parent that does the probing, in order
to avoid adding bcma specific code to drivers/of/platform.c

	Arnd
