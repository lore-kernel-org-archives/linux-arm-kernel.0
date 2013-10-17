From: msalter@redhat.com (Mark Salter)
Date: Thu, 17 Oct 2013 12:58:34 -0400
Subject: [PATCH v2 2/3] arm: Add [U]EFI runtime services support
In-Reply-To: <20131017143121.GJ1557@rocoto.smurfnet.nu>
References: <1380799481-5470-1-git-send-email-leif.lindholm@linaro.org>
 <1380799481-5470-3-git-send-email-leif.lindholm@linaro.org>
 <20131017140739.GI10834@console-pimps.org>
 <20131017143121.GJ1557@rocoto.smurfnet.nu>
Message-ID: <1382029114.1768.10.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-10-17 at 16:31 +0200, Leif Lindholm wrote:
> On Thu, Oct 17, 2013 at 03:07:39PM +0100, Matt Fleming wrote:
> > > +/*
> > > + * If you need to (temporarily) support buggy firmware.
> > > + */
> > > +#define KEEP_BOOT_SERVICES_REGIONS
> > 
> > Have you seen firmware that requires this? I'm just curious more than
> > anything else.
> 
> Not really.
> I _think_ I saw it on a debug build of a development platform once.
> That coincided with me seeing a post on linux-efi about some laptop
> that broke unless boot services regions were preserved, so I decided
> to put it in there for any future debugging.
>  

I see a fairly consistent segfault when the arm64 kernel calls the
SetVirtualAddressMap function. It doesn't happen when the boot services
regions are included in the mapping. This is with edk2 firmware. I
haven't really dug into where it goes wrong.
