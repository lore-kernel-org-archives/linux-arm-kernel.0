From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Mon, 23 Mar 2015 19:05:11 +0000
Subject: [RFC PATCH 1/7] serial: Emulate break using control characters
In-Reply-To: <20150323162805.GA3579@e103592.cambridge.arm.com>
References: <1426688428-3150-1-git-send-email-daniel.thompson@linaro.org>
 <1426688428-3150-2-git-send-email-daniel.thompson@linaro.org>
 <20150320142847.GB4725@e103592.cambridge.arm.com>
 <55103125.7080500@linaro.org>
 <20150323162805.GA3579@e103592.cambridge.arm.com>
Message-ID: <20150323190511.76b02115@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > To be clear I included the patch in this series only because:
> > 
> > 1. I couldn't figure out any way to send a serial break to the ARM
> >    Foundation Model making it impossible for me to provoke SysRq actions
> >    from interrupt context,
> 
> Agreed, there's no direct way to do it (annoyingly).
> 
> Arguably that's a deficiency in the model, though that's not much help to
> you right now.

If it isn't affecting real hardware and it's just for a flawed model then
hack a check for a suitable symbol into the specific patches for
the model and its serial driver and claim it was a break - don't dump it
into the mainstream.

There are some "conventional" escapes platforms have used (ctrl and
symbols for example such as ctrl-^) which are less likely to cause
conflicts than sequences. Nevetheless its not something you want anywhere
mainstream if you can avoid it because those symbols could be sent over a
remote management modem or similar.

They may be better if it does need to end up in the core kernel.

Alan
