From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 27 May 2014 16:35:03 +0800
Subject: [linux-sunxi] Re: [PATCH 01/11] pinctrl: sunxi: create irq/pin
 mapping during init
In-Reply-To: <20140527080257.GA4730@lukather>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
 <1401090486-4414-2-git-send-email-hdegoede@redhat.com>
 <20140527080257.GA4730@lukather>
Message-ID: <CAGb2v66MB79bxhYq=iQy75OZ9KxtjocY+tVxZPN1NoVhPe=edQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 4:02 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Mon, May 26, 2014 at 09:47:56AM +0200, Hans de Goede wrote:
>> From: Chen-Yu Tsai <wens@csie.org>
>>
>> The irq/pin mapping is used to lookup the pin to mux to the irq
>> function when the irq is enabled. It is created when gpio_to_irq
>> is called. Creating the mapping during init allows us to map the
>> interrupts directly from the device tree.
>
> Can you be a bit more precise on this?
>
> What is the issue that this patch fix?

IIRC, originally the IRQ to pin mapping was created when gpio_to_irq
was called with a GPIO handle. The mapping in turn is used to mux
the pin into EINT mode.

If the mapping is created during gpio_to_irq, we can't use the
interrupts directly, i.e. through the DT with "interrupts = <&pio A 4>".

Instead we'd have to use "gpios = <&pio A B>", then pass the gpio
through to gpio_to_irq.


ChenYu
