From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 8 May 2015 08:25:27 +0100
Subject: [STLinux Kernel] [PATCH 06/12] watchdog: bindings: Supply
 knowledge of a third supported device - clocksource
In-Reply-To: <20150508071604.GA2232@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-7-git-send-email-lee.jones@linaro.org>
 <20150507141805.GC9793@griffinp-ThinkPad-X1-Carbon-2nd>
 <20150507191909.GC16220@x1>
 <20150507195529.GA28554@griffinp-ThinkPad-X1-Carbon-2nd>
 <20150508064918.GF16220@x1>
 <20150508071604.GA2232@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20150508072527.GI16220@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 08 May 2015, Peter Griffin wrote:
> On Fri, 08 May 2015, Lee Jones wrote:
> > > > > >  
> > > > > > -- compatible 	: Must be one of: "st,stih407-lpc" "st,stih416-lpc"
> > > > > > -				  "st,stih415-lpc" "st,stid127-lpc"
> > > > > > +- compatible 	: Must be one of: "st,stih407-lpc"
> > > > > 
> > > > > The same comment as the RTC DT patch, you are removing the compatibles
> > > > > documentation for the other supported platforms like stih416-lpc.
> > > > > AFAIK they are required in the driver to get the correct sysconfig register.
> > > > 
> > > > That's intentional.  I haven't yet tested any of this IP on
> > > > STiH41{5,6} & STiH127.  Due to lack of documentation, I'm not even
> > > > sure if this IP even exists on some of the other platforms.  I will
> > > > add them back when support is added to both driver and DTB and I've
> > > > been able to test them.
> > > 
> > > That was kind of my point, the driver code AFAIK already contains support
> > > for these SoC's.
> > > 
> > > I would either expect the patch to remove support from the DT docs AND the
> > > driver, or leave it as is.
> > > 
> > > It seems odd to only change the DT docs, and become unaligned to the
> > > code (this assumes I'm looking at the latest patchset here 
> > > https://lkml.org/lkml/2015/3/4/1088 which includes support for these SoCs).
> > 
> > The decision to remove these 'supported' platforms was made on the RTC
> > side, where there is only support for "st,stih407-lpc" in the driver.
> 
> The change makes sense in the RTC case then.
> 
> > I thought it best to mirror that thought over to the Watchdog LPC
> > bindings,
> 
> Why? This is the bit I disagree with, the wdt DT docs IMHO should match the wdt
> driver code.

Fair enough.  I'll add the 'supported' compatibles back in.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
