From: Scott.Lurndal@cavium.com (Lurndal, Scott)
Date: Mon, 20 Mar 2017 11:50:02 -0700
Subject: [Linaro-acpi] [PATCH v21 13/13] acpi/arm64: Add SBSA Generic
 Watchdog support in GTDT driver
In-Reply-To: <20170320180949.GM31213@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-14-fu.wei@linaro.org>
 <20170317200153.GF15909@leverpostej>
 <CADyBb7uZV2Qe0ga4TTS_iis5MtwJ=u6PKYSV6ED103Cmh5_O3g@mail.gmail.com>
 <20170320180949.GM31213@leverpostej>
Message-ID: <20170320185002.GT31496@slurndal-lnx1.caveonetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 06:09:50PM +0000, Mark Rutland wrote:
> On Tue, Mar 21, 2017 at 01:57:58AM +0800, Fu Wei wrote:
> > On 18 March 2017 at 04:01, Mark Rutland <mark.rutland@arm.com> wrote:
> > > On Tue, Feb 07, 2017 at 02:50:15AM +0800, fu.wei at linaro.org wrote:
> 
> > > I've not been able to find where the ACPI spec says that zero is not a
> > > valid GSIV. This may simply be an oversight/ambiguity in the spec.
> > >
> > > Is there any statement to that effect?
> > 
> > you are right, zero is a  valid GSIV, I will delete this check. Thanks
> 
> That being the case, how does one describe a watchdog that does not have
> an interrupt?
> 
> As I mentioned, I think this is an oversight/ambiguity in the spec tat
> we should address.
> 
> > > My reading of SBSA is that there is one watchdog in the system.
> > >
> > > Is that not the case?
> > 
> > do you mean:
> > ---------------
> > 4.2.4 Watchdogs
> > The base server system implements a Generic Watchdog as specified in
> > APPENDIX A: Generic Watchdog.
> > ---------------
> > 
> > I am not sure about that if this is saying "we only have one SBSA
> > watchdog in a system"
> > 
> > would you let me know where mention it? Do I miss something?
> 
> My reading was that the 'a' above meant a single element. i.e.
> 
> 	The base server system implements _a_ Generic Watchdog as
> 	specified in APPENDIX A: Generic Watchdog.

  It is a requirement of a conforming implementation that there
be a generic watchdog (impl as per the appendix).   That doesn't preclude
an implmentation from providing additional watchdogs (for example, if
the processor implements EL3, it is likely that an implementation
will include a secure watchdog as well as a non-secure watchdog).

  The SBSA describes the minimal hardware requirements for a
compliant server.

scott
