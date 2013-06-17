From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Mon, 17 Jun 2013 11:15:58 -0700
Subject: [PATCH] pinctrl: document the pinctrl PM states
In-Reply-To: <CACRpkdbZ6QCU1N_3no+rahjVFSUgYMrDqtXW=4AjaY4RhaF9Zw@mail.gmail.com>
References: <1370980749-15383-1-git-send-email-linus.walleij@stericsson.com>
 <51BA1FE7.4000900@wwwdotorg.org>
 <CACRpkdZV7R3MgbuvEMhs24YYv2hK8Kt9Kjmv_cpRQQ1NYviDQg@mail.gmail.com>
 <51BB3A2C.608@wwwdotorg.org> <20130617072021.GB4465@atomide.com>
 <CACRpkdbZ6QCU1N_3no+rahjVFSUgYMrDqtXW=4AjaY4RhaF9Zw@mail.gmail.com>
Message-ID: <51BF525E.5080508@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/17/2013 8:56 AM, Linus Walleij wrote:
> On Mon, Jun 17, 2013 at 9:20 AM, Tony Lindgren <tony@atomide.com> wrote:
>
>> Maybe let's again try to first list all the known cases where we need to
>> do remuxing, and the pins we need to remux?
> In the pinctrl documentation this is known as "runtime pinmuxing".
> This is not common, it is much more common to change
> pin config, i.e. all other electrical properties of the pins,
> at runtime. Especially when going to sleep or idle.

MSM also does a significant amount of *remuxing* during suspend/resume.
We have cases where a pin might be connected to a different device 
during normal
operation with a different pull and higher drive strength and we will 
put it
gpio mode, input for a low power configuration.
Consolidating them into 1 operation would be preferred.

>> Below are the pin remuxing cases I'm aware of:
>>
>> 1. Remux UART RX pin of a device for a wake-up event
>>
>> 2. Remux whatever device interrupt line to a GPIO input for wake-up
>>
>> 3. Remux audio jack between UART RX and TX to provide a debug console
>>
>> 4. Remux MMC CMD and DAT lines for sleep with pulls to avoid device
>>     from resetting with lines floating or to save power
>>
>> Please list any further use cases that I'm not familiar with. I'd like
>> to hear how messed up this remuxing business can get :)
> We have a debug port that can be muxed out on the keypad(!)
> or the SD card, and some other variants...
>
> Stephen added the I2C block switch thing that switch one
> and the same IP core between different sets of pins (IIRC).
>
> For runtime pin config I have many more examples, we
> change a lot of those to so-called "GPIO mode" (basically
> just turned into an input with wakeup,  or pulled to ground)
> at sleep.
>
> Yours,
> Linus Walleij
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


Thanks,
Rohit Vaswani

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation
