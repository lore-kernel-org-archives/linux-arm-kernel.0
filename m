From: will.deacon@arm.com (Will Deacon)
Date: Thu, 5 Jul 2012 10:33:48 +0100
Subject: [PATCH 1/2] ARM: vexpress: add debug UARTs to DEBUG_LL kconfig
 choice
In-Reply-To: <1341480232.1173.22.camel@hornet>
References: <1341414076-20895-1-git-send-email-will.deacon@arm.com>
 <1341480232.1173.22.camel@hornet>
Message-ID: <20120705093348.GA3399@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

On Thu, Jul 05, 2012 at 10:23:52AM +0100, Pawel Moll wrote:
> On Wed, 2012-07-04 at 16:01 +0100, Will Deacon wrote:
> > This patch avoids probing the various possible UART locations on the
> > different Versatile Express motherboards and instead adds entries into
> > the DEBUG_LL kconfig choice for the two possible memory maps.
> 
> I wrote similar thing (keeping the autodetection as one of the options)
> some time ago, but Russell didn't like it (because it wasn't DEBUG_LL
> choice) and I didn't have time to rework it for 3.5 merge window. Will
> get this out this time.

Ok, thanks. We have similar code in mach/uncompress.h -- how do you feel
about using the same approach there? I've seen the decompressor explode due
to the mrc and it's a royal pain to track down.

Will
