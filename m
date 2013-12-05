From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 5 Dec 2013 12:16:59 -0800
Subject: [PATCH 0/3] ARM Coresight: Enhance ETM tracing control
In-Reply-To: <52A0DE42.3080602@codeaurora.org>
References: <CANsc=4VRLWhaVA15HrBEeM+FJC0tS+b5KKopDb7bP8nxzR8=zA@mail.gmail.com>
 <20131204070442.GA31665@kroah.com>
 <CANsc=4UHEG5cmg9SD3r3rsuJnM9zqq2WiTQdUwrYFr_kkbsVvg@mail.gmail.com>
 <20131204170703.GA14859@kroah.com>
 <CANsc=4X7ThCvgz9bfu1ZZg9FCti5SMdbXL5tA584z-oZ_HEByg@mail.gmail.com>
 <20131204230239.GB9205@kroah.com>
 <CANsc=4UGi5sMdUW5qQDzEJx4h8NDU+-b=xOLBAZtzbV5ugz3Fg@mail.gmail.com>
 <20131205040104.GA14641@kroah.com>
 <52A0DE42.3080602@codeaurora.org>
Message-ID: <20131205201659.GA14539@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 03:12:50PM -0500, Christopher Covington wrote:
> Hi Greg,
> 
> On 12/04/2013 11:01 PM, Greg Kroah-Hartman wrote:
> > On Wed, Dec 04, 2013 at 10:49:25PM -0500, Adrien Verg? wrote:
> >> 2013/12/4 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> >>> How much overhead does the existing tracing code have on ARM?  Is ETM
> >>> still even needed?  Why not just use ETM for the core tracing code
> >>> instead?
> 
> I think support for the Embedded Trace Macrocell is desirable. (Maybe it's not
> necesarily *needed*, but in the same way that graphics and audio aren't
> necessarily needed when using a desktop machine.) Plugging the ETM into the
> core tracing code or maybe into the perf events framework would be
> interesting, but do these patches make that work any more difficult?

Well, these patches were incorrect, so that's not really a valid
question :)

And adding new features to code that is "dead" and should probably be
removed isn't a good idea, as I'm sure you can understand.

> >> Coresight ETM is not just faster than /sys/kernel/debug/tracing, it
> >> provides more detailed and customisable info. For instance, you can
> >> trace every load, store, instruction fetch, along with the number of
> >> cycles taken, with almost zero-overhead.
> > 
> > Can't you already do that with the 'perf' tool the kernel provides
> > without the ETM driver?
> 
> With perf one can get a count of how many instructions have been executed,
> with little overhead, but not the full list of opcodes and addresses.

Is that a limitation of perf on ARM or perf in general?  For some reason
I thought I had seen this using perf on x86, but it's been a while since
I last used it.

> (One can also sample the Program Counter intermittently, which might
> suffice for performance analysis, but probably doesn't for most
> debugging use cases.) I think with perf one can have a handful of
> watchpoints looking at a very few loads and stores, with large
> overhead. As I understand it, ETM can handle arbitrarily large
> regions, with little overhead.

How much work is it to incorportate ETM into the perf framework?  Don't
you think that this is a better thing to do overall, instead of having
duplicating interfaces for the same thing?

thanks,

greg k-h
