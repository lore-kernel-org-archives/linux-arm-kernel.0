From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 31 Mar 2010 15:53:11 -0700
Subject: [PATCH 1/4] arm: msm: gpio support
In-Reply-To: <l2ud6200be21003311421p8dc78179sf62b1d62d468528a@mail.gmail.com>
References: <1269990717-2969-1-git-send-email-dwalker@codeaurora.org>
	<0D753D10438DA54287A00B027084269763691C346E@AUSP01VMBX24.collaborationhost.net>
	<d6200be21003301814m538a5902s649415d6cc7ec8fa@mail.gmail.com>
	<1270044182.2025.0.camel@m0nster>
	<l2ud6200be21003311421p8dc78179sf62b1d62d468528a@mail.gmail.com>
Message-ID: <1270075991.2488.9.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-03-31 at 14:21 -0700, Arve Hj?nnev?g wrote:
> 2010/3/31 Daniel Walker <dwalker@codeaurora.org>:
> > On Tue, 2010-03-30 at 18:14 -0700, Arve Hj?nnev?g wrote:
> >> On Tue, Mar 30, 2010 at 4:58 PM, H Hartley Sweeten
> >> <hartleys@visionengravers.com> wrote:
> >> > On Tuesday, March 30, 2010 4:12 PM, Daniel Walker wrote:
> >> >> From: Daniel Walker <c_dwalke@quicinc.com>
> >> ...
> >> >> +
> >> >> +static void msm_gpio_irq_ack(unsigned int irq)
> >> >> +{
> >> >> +     unsigned long irq_flags;
> >> >> +     struct msm_gpio_chip *msm_chip = get_irq_chip_data(irq);
> >> >> +     unsigned b;
> >> >> +
> >> >> +     spin_lock_irqsave(&msm_chip->lock, irq_flags);
> >> >> +
> >> >> +     b = 1U << (irq - FIRST_GPIO_IRQ - msm_chip->chip.base);
> >> >
> >> > Urk... That's a bit confusing...
> >> >
> >> > You might want to make this a macro or an inline function with some kind
> >> > of comment.
> >> >
> >>
> >> On a related note, why did you inline msm_gpio_clear_detect_status? It
> >> is used from two other functions.
> >>
> >
> > You mean other places in the Android tree?
> 
> No, you copied it three times in this file.

Oh, well it was part of the API elimination , but it's helpful when
doing clean up to have stuff all unrolled so optimization possibilities
present themselves more easily .. You think I should convert it into an
inline?

Daniel
