From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 May 2011 21:56:44 +0100
Subject: [PATCH v5 8/8] MTD: physmap: let set_vpp() pass a
	platform_device instead of a map_info
In-Reply-To: <BANLkTi=-Lcg5Wk7yuipTTzrSxs0nNmpMaw@mail.gmail.com>
References: <1305557977-16871-1-git-send-email-marc.zyngier@arm.com>
	<1305557977-16871-9-git-send-email-marc.zyngier@arm.com>
	<BANLkTi=-Lcg5Wk7yuipTTzrSxs0nNmpMaw@mail.gmail.com>
Message-ID: <20110516205644.GG13659@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2011 at 11:06:10PM +0800, Eric Miao wrote:
> On Mon, May 16, 2011 at 10:59 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > The set_vpp() method provided by physmap passes a map_info back to
> > the platform code, which has little relevance as far as the platform
> > is concerned (this parameter is completely unused).
> >
> > Instead, pass the platform_device, which can be used in the pismo
> > driver to retrieve some important information in a nicer way, instead
> > of the hack that was in place.
> 
> Not really sure if a 'struct device' would be more generic here, though this
> case is simply a 'struct platform_device'.

As it's a platform device driver (at the moment), passing the platform
device seems logical.

If it becomes an DT based device driver, then we need some other way of
describing the set_vpp etc functionality as we can't describe function
pointers in DT (the same problem goes for a lot of platform device
drivers.)
