From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 7 Oct 2013 19:19:41 -0700
Subject: Use of drivers/platform and matching include?
In-Reply-To: <52535151.2000508@codeaurora.org>
References: <BC1C47B3-5412-4829-A1D9-AAB04694D1CC@codeaurora.org>
 <CAOesGMjJ6Uj0uGFJqtnWQyDW+tr6eLVWoHZ+B7uFna+L8N6E8Q@mail.gmail.com>
 <20131004114128.GL12758@n2100.arm.linux.org.uk>
 <20131004132209.GB23923@kroah.com>
 <CAOesGMjxwmr0Vo0Puc-nZntgXLy6D1PTohz=C+fFukP_Eu1iQg@mail.gmail.com>
 <20131005171323.GB5780@kroah.com> <52535151.2000508@codeaurora.org>
Message-ID: <20131008021941.GA9427@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 05:26:57PM -0700, Rohit Vaswani wrote:
> On 10/5/2013 10:13 AM, Greg Kroah-Hartman wrote:
> > On Fri, Oct 04, 2013 at 09:48:41AM -0700, Olof Johansson wrote:
> >> On Fri, Oct 4, 2013 at 6:22 AM, Greg Kroah-Hartman
> >> <gregkh@linuxfoundation.org> wrote:
> >>> On Fri, Oct 04, 2013 at 12:41:28PM +0100, Russell King - ARM Linux wrote:
> >>>> So, no, there will be no new drivers under arch/arm.  They must be in the
> >>>> drivers subtree somewhere.
> >>> I have no objection with this, and encourage it.
> >> Ok, so these are some of the requirements as far as I see it:
> >>
> >> * No per-vendor driver dumping ground under drivers/* (i.e. no
> >> drivers/platform/<soc vendor>/)
> > Yes.
> 
> We agree that there is no need for a dump *all* drivers under 
> arm/mach-foo in drivers/platform/foo/. The msm bus driver would be added 
> under drivers/bus/. But, we still have some drivers which are quite SoC 
> specific and not in the general category of the sub-directories present 
> under drivers.
> As Kumar mentioned earlier -
> 
> An example driver would be the means we utilize to communicate memory
> regions between various HW blocks on the SoC.  So a video/media core
> driver might need access to a header/functions from the memory region
> driver.
> 
> Would drivers/misc/qcom-* or drivers/misc/qcom/* be a reasonable place
> to add them ? and the headers could go into include/linux/qcom-*.h

That seems reasonable, but I'd have to see the code to verify this.

greg k-h
