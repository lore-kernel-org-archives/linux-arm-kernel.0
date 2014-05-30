From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 30 May 2014 14:37:41 -0600
Subject: [PATCH] of: treat PCI config space as IORESOURCE_MEM type
In-Reply-To: <20140530014116.GF1677@bart.dudau.co.uk>
References: <1401379426-9701-1-git-send-email-galak@codeaurora.org>
 <CAL_JsqLPFDwtd-QYDqCwx1JVj1Aa8=nof-e0P6R9CZra+fXHfw@mail.gmail.com>
 <47B1E3D0-4336-4529-80B0-172F4ACA5C97@codeaurora.org>
 <20140530005602.GE1677@bart.dudau.co.uk>
 <CAErSpo7qEhJyUAu58R8g6+AEhRGo_+Vv0EMgkK+3ZQOU9+jmhg@mail.gmail.com>
 <20140530014116.GF1677@bart.dudau.co.uk>
Message-ID: <20140530203741.GA30134@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 02:41:17AM +0100, Liviu Dudau wrote:

> Agree, I'm only concerned that if this ECAM config space gets added to
> the list of pci_host_bridge windows it will be indistinguishable from
> IORESOURCE_MEM resources and pci_create_root_bus() will add it to the
> bus and allow devices present on that bus to be assigned addresses from
> that range. Which might not be what one wants for certain BARs.

I wouldn't worry about supporting config in ranges. ECAM is the
logical use for config ranges, but it isn't specified and probably
will never be.

Will's driver the is the only driver I've seen to support ECAM and it
didn't use ranges.

Jason
