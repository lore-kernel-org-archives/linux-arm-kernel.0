From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 4 Apr 2014 09:53:29 -0700
Subject: [PATCH 74/75] ARM: l2c: always enable low power modes
In-Reply-To: <20140328155127.GL7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYaK-0007I0-Sm@rmk-PC.arm.linux.org.uk>
 <CAL_Jsq+vja-BeNfiVnOicFAa+E6jigDfnb5KWWpxZCZ3eGkJiA@mail.gmail.com>
 <20140328155127.GL7528@n2100.arm.linux.org.uk>
Message-ID: <b3b6dd79-5646-4c9f-8e62-ed9c4a5596e3@VA3EHSMHS040.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-03-28 at 03:51PM +0000, Russell King - ARM Linux wrote:
> On Fri, Mar 28, 2014 at 10:42:54AM -0500, Rob Herring wrote:
> > On Fri, Mar 28, 2014 at 10:20 AM, Russell King
> > <rmk+kernel@arm.linux.org.uk> wrote:
> > > Always enable the L2C low power modes on L2C-310 R3P0 and newer parts.
> > 
> > I assume you want to squash this with patch 68/75? Or you are still
> > debating whether we want to do this or not? Given that it is r3px
> > only, that should greatly reduce any chance of breakage to newer
> > platforms.
> 
> I will eventually - I've kept it separate for the time being to give
> more options.  Let's see how people get on with it - it'll be running
> through Olof's builder later today, and there's some other people
> wanting to take it for a spin.

A while back I suggested altering those bits, but that was turned down:
https://lkml.org/lkml/2013/3/1/350

Are there any numbers available on how enabling these features impacts
the system? I'm a little bit concerned of always enabling them
unconditionally, in case it increases latency for some use cases. I
think I'd prefer the DT approach, unless the impact is reported to be
negligible - which it likely is, I guess.

	Thanks,
	S?ren
