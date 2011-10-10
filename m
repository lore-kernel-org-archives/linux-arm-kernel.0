From: gregkh@suse.de (Greg KH)
Date: Mon, 10 Oct 2011 10:38:45 -0700
Subject: [PATCH] fix ehci alignment error
In-Reply-To: <20115.11246.991917.639835@pilspetsen.it.uu.se>
References: <20111010124154.464239811@gmail.com>
	<20111010141402.GA21856@suse.de>
	<yw1xipnwzu7a.fsf@unicorn.mansr.com>
	<20111010170042.GB24166@suse.de>
	<20115.11246.991917.639835@pilspetsen.it.uu.se>
Message-ID: <20111010173845.GB25114@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2011 at 07:31:26PM +0200, Mikael Pettersson wrote:
> Greg KH writes:
>  > On Mon, Oct 10, 2011 at 05:29:13PM +0100, M?ns Rullg?rd wrote:
>  > > Greg KH <gregkh@suse.de> writes:
>  > > 
>  > > > On Mon, Oct 10, 2011 at 02:38:27PM +0200, Harro Haan wrote:
>  > > >> The Kirkwood gave an unaligned memory access error on
>  > > >> line 742 of drivers/usb/host/echi-hcd.c:
>  > > >> "ehci->last_periodic_enable = ktime_get_real();"
>  > > >
>  > > > What is "The Kirkwood"?  What size processor is this?
>  > > 
>  > > It's an ARM926-like CPU from Marvell.
>  > 
>  > 32 or 64bit?
> 
> All ARMs are 32-bit, but some have instructions for loading or
> storing 2 x 32 bits at a time, but also require the corresponding
> memory address to be 64-bit aligned.

Ah, ok, that makes more sense here.  I'll go queue it up.

greg k-h
