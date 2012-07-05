From: will.deacon@arm.com (Will Deacon)
Date: Thu, 5 Jul 2012 10:42:18 +0100
Subject: [PATCH 1/2] ARM: vexpress: add debug UARTs to DEBUG_LL kconfig
 choice
In-Reply-To: <1341481080.1173.28.camel@hornet>
References: <1341414076-20895-1-git-send-email-will.deacon@arm.com>
 <1341480232.1173.22.camel@hornet>
 <20120705093348.GA3399@mudshark.cambridge.arm.com>
 <1341481080.1173.28.camel@hornet>
Message-ID: <20120705094218.GB3399@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 10:38:00AM +0100, Pawel Moll wrote:
> On Thu, 2012-07-05 at 10:33 +0100, Will Deacon wrote:
> > 
> > Ok, thanks. We have similar code in mach/uncompress.h -- how do you feel
> > about using the same approach there? I've seen the decompressor explode due
> > to the mrc and it's a royal pain to track down.
> 
> This was the reason my Kconfig options weren't in DEBUG_LL but in
> ARCH_VEXPRESS - to serve both decompressor and early console. But as it
> was NAKed I'm considering several options, one (the simplest) of them is
> printing nothing in the decompressor unless DEBUG_LL is selected.

Indeed, that's the option I'd favour but I thought I'd check whether you
were alright with that before updating the patch.

Will
