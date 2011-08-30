From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 30 Aug 2011 17:51:17 +0530
Subject: [PATCH 4/6] DMA: PL330: Add device tree support
In-Reply-To: <20110826142305.GA23469@n2100.arm.linux.org.uk>
References: <1314348014-2481-1-git-send-email-thomas.abraham@linaro.org>
	<1314348014-2481-2-git-send-email-thomas.abraham@linaro.org>
	<1314348014-2481-3-git-send-email-thomas.abraham@linaro.org>
	<1314348014-2481-4-git-send-email-thomas.abraham@linaro.org>
	<1314348014-2481-5-git-send-email-thomas.abraham@linaro.org>
	<4E579C9B.7030807@gmail.com>
	<20110826142305.GA23469@n2100.arm.linux.org.uk>
Message-ID: <CAJuYYwR6_67d4h7dvF+67JnnEqhPyWrXqJ=tTE32wnzkNfabzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 26 August 2011 19:53, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> On Fri, Aug 26, 2011 at 08:16:11AM -0500, Rob Herring wrote:
> > Thomas,
> >
> > On 08/26/2011 03:40 AM, Thomas Abraham wrote:
> > > + ?- arm,pl330-peri-reqs: number of actual peripheral requests connected to the
> > > + ? ?dma controller. Maximum value is 32.
> >
> > Perhaps could be a bitmask for sparsely populated requests. May not
> > matter since phandles will define the connections.
> >
> > Can be optional and not present means 00 requests (mem-to-mem only).
>
> The number of peripheral requests is readable from configuration register
> zero, so this is discoverable. ?Why should we put this information into
> DT if its provided by the hardware?
>
> The number of DMA channels available is also configurable by the SoC
> designer, yet you don't specify that in DT. ?And there's a whole bunch
> of other configuration options available to the SoC designer, most of
> which are discoverable from the configuration registers.
>
> So, I don't think you should be specifying the number of requests.

Ok. The property specifying the number of peripheral requests will be dropped.

Thanks,
Thomas.
