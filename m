From: dmitriyz@google.com (Dima Zavin)
Date: Wed, 26 Jan 2011 14:50:30 -0800
Subject: [PATCH v2 02/11] msm: Generalize timer register mappings
In-Reply-To: <8ya7hdr70fw.fsf@huya.qualcomm.com>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
	<1295468747-22796-3-git-send-email-davidb@codeaurora.org>
	<1295908604.29639.62.camel@c-dwalke-linux.qualcomm.com>
	<8yaei81kjlc.fsf@huya.qualcomm.com>
	<AANLkTi=UBfBp-VOQ=n_a4sjA9v_dhcv-rXcXiE6zrf23@mail.gmail.com>
	<8ya7hdr70fw.fsf@huya.qualcomm.com>
Message-ID: <AANLkTinzALPyX5ehXD_DMALt4szqA2hXzguohAGkzVbe@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 26, 2011 at 2:41 PM, David Brown <davidb@codeaurora.org> wrote:
> On Wed, Jan 26 2011, Dima Zavin wrote:
>
>> On Mon, Jan 24, 2011 at 2:44 PM, David Brown <davidb@codeaurora.org> wrote:
>
>> To be honest I don't understand why you would want to do this at
>> runtime. You cannot select multiple SoCs in the kernel build anyway,
>> nor would you want to. Trying to have same kernel to boot on ARM v6
>> and ARM v7 would already be freaky enough. On top of that mixing 7201a
>> with all the baggage that it comes with 8x60 just wouldn't make sense.
>> These architectures are so different that it I can't see that ever
>> being useful. When would you ever envision building for multiple of
>> these SoCs at the same time?
>
> People (especially distributions) want to be able to build one arm
> kernel rather than multiple ones. ?The issues about CPU detection and
> base addresses are being worked on now.

Yeah, you are right. I guess for distributions that would make a lot
of sense. Point taken.

I think the hard part for msm will be in the peripheral drivers and
not in core. The subtle ways in which all the bits move around in the
peripherals like the display and nand controllers made it very hard
without doing defines and build time. I'm not sure how much worse or
better it is in TI land?

--Dima

> Other targets, especially omap, are already way ahead of MSM in this
> area.


>
> David
>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>
