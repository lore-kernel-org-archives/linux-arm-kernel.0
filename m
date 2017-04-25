From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Tue, 25 Apr 2017 21:07:47 +0200 (CEST)
Subject: [PATCH 1/5 v3] usb: host: add DT bindings for faraday fotg2
In-Reply-To: <CACRpkda-2OQZJDQndrDg_d4iK4oecz4HNSCQPSztBFTG5Rwg8w@mail.gmail.com>
References: <20170421204058.6206-1-linus.walleij@linaro.org>
 <alpine.LNX.2.00.1704241846300.15211@T420s>
 <CACRpkda-2OQZJDQndrDg_d4iK4oecz4HNSCQPSztBFTG5Rwg8w@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1704252104010.17792@T420s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus

On Tue, 25 Apr 2017, Linus Walleij wrote:

> On Mon, Apr 24, 2017 at 6:53 PM, Hans Ulli Kroll
> <ulli.kroll@googlemail.com> wrote:
> 
> > Got NAK'ed from Rob on some ealier round due missing "device mode" on this
> > IP. I've blatantly overrided this to a host only driver.
> >
> > These are the needed changes in DT to support both modes
> > Note the -dr at the end of fotg210, to reflect this in an dual role device
> 
> OK I understood the discussion such that the compatible should
> simply be ""faraday,fotg210" as that is the name of the hardware
> IP block. This is the name of the hardware name in the Faraday
> page:
> http://www.faraday-tech.com/html/Product/IPProduct/InterfaceIP/USB2_0.htm
> 
> Any other string implies how it is used, so that was what I understood
> as the reason to reject it with the "-hcd" (host controller device) suffix.
> 
> > +- dr_mode : indicates the working mode for "fotg210-dr" compatible
> > +   controllers.  Can be "host", "peripheral". Default to
> > +   "host" if not defined for backward compatibility.
> 
> This seems right, so it is part of the generic bindings, correct?
> 
> >  usb at 68000000 {
> > -       compatible = "cortina,gemini-usb", "faraday,fotg210";
> > +       compatible = "cortina,gemini-usb", "faraday,fotg210-dr";
> 
> But this would be wrong, because the compatible should only
> indicate what kind of hardware it is, not how it is going to be used
> (whether as host only, slave only or dual-role (OTG).
> 

for compatible I think yes.
But in Rob's opinion we missed the device part of the controller.

Greetings
Hans Ulli Kroll
