From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 4 Dec 2013 20:01:04 -0800
Subject: [PATCH 0/3] ARM Coresight: Enhance ETM tracing control
In-Reply-To: <CANsc=4UGi5sMdUW5qQDzEJx4h8NDU+-b=xOLBAZtzbV5ugz3Fg@mail.gmail.com>
References: <CANsc=4VRLWhaVA15HrBEeM+FJC0tS+b5KKopDb7bP8nxzR8=zA@mail.gmail.com>
 <20131204070442.GA31665@kroah.com>
 <CANsc=4UHEG5cmg9SD3r3rsuJnM9zqq2WiTQdUwrYFr_kkbsVvg@mail.gmail.com>
 <20131204170703.GA14859@kroah.com>
 <CANsc=4X7ThCvgz9bfu1ZZg9FCti5SMdbXL5tA584z-oZ_HEByg@mail.gmail.com>
 <20131204230239.GB9205@kroah.com>
 <CANsc=4UGi5sMdUW5qQDzEJx4h8NDU+-b=xOLBAZtzbV5ugz3Fg@mail.gmail.com>
Message-ID: <20131205040104.GA14641@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 10:49:25PM -0500, Adrien Verg? wrote:
> 2013/12/4 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> > How much overhead does the existing tracing code have on ARM?  Is ETM
> > still even needed?  Why not just use ETM for the core tracing code
> > instead?
> 
> Coresight ETM is not just faster than /sys/kernel/debug/tracing, it
> provides more detailed and customisable info. For instance, you can
> trace every load, store, instruction fetch, along with the number of
> cycles taken, with almost zero-overhead.

Can't you already do that with the 'perf' tool the kernel provides
without the ETM driver?

> > What's wrong with the in-kernel tracing logic that you can't use that
> > instead of the ETM stuff?
> 
> ETM has a different purpose. Integrating it in
> /sys/kernel/debug/tracing would not take advantage of all its
> features.

What is it's purpose then?  At first glance, this seems to be exactly
what 'perf' provides already.  Doesn't perf work on ARM today?

thanks,

greg k-h
