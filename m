From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 2 Dec 2010 23:14:57 +0000
Subject: [PATCH 3/4] plat-s5p: Add platform support for MIPI-CSI2 devices
In-Reply-To: <4CF7D9E6.5000409@samsung.com>
References: <1291307862-8125-1-git-send-email-s.nawrocki@samsung.com>
	<1291307862-8125-4-git-send-email-s.nawrocki@samsung.com>
	<20101202171538.GB30933@pulham.picochip.com>
	<4CF7D9E6.5000409@samsung.com>
Message-ID: <20101202231457.GA12385@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 02, 2010 at 06:39:50PM +0100, Sylwester Nawrocki wrote:
> On 12/02/2010 06:15 PM, Jamie Iles wrote:
> > On Thu, Dec 02, 2010 at 05:37:41PM +0100, Sylwester Nawrocki wrote:
[...]
> >> +static struct resource s5p_csis_resource[] = {
> >> +	[0] = {
> >> +		.start = S5P_PA_CSIS0,
> >> +		.end   = S5P_PA_CSIS0 + SZ_4K - 1,
> >> +		.flags = IORESOURCE_MEM,
> >> +	},
> >> +	[1] = {
> >> +		.start = IRQ_MIPICSI0,
> >> +		.end   = IRQ_MIPICSI0,
> >> +		.flags = IORESOURCE_IRQ,
> >> +	}
> >> +};
> > Do you really need the [0] and [1] here? These are only needed if you are 
> > sparsely initialising an array.
> 
> I agree explicit indices are not really needed. I just followed the style of
> all other resource definitions already there.
> I am not quite sure what is the preference of the maintainer, I guess they want
> all devices to follow same style for consistence.
Ok, that's fair enough, it just looked a bit odd to me!

Jamie
