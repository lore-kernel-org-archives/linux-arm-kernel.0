From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 May 2011 16:14:56 +0100
Subject: [PATCH v5 8/8] MTD: physmap: let set_vpp() pass a
	platform_device instead of a map_info
In-Reply-To: <BANLkTi=-Lcg5Wk7yuipTTzrSxs0nNmpMaw@mail.gmail.com>
References: <1305557977-16871-1-git-send-email-marc.zyngier@arm.com>
	<1305557977-16871-9-git-send-email-marc.zyngier@arm.com>
	<BANLkTi=-Lcg5Wk7yuipTTzrSxs0nNmpMaw@mail.gmail.com>
Message-ID: <1305558896.30788.15.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-05-16 at 23:06 +0800, Eric Miao wrote:
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

While I agree that 'struct device' is more generic, physmap only knows
about platform_devices. Should another device type be added to physmap,
this would make sense. But at the moment I'd like to limit the code
churn to what is strictly necessary.

Cheers,

	M.
-- 
Reality is an implementation detail.
