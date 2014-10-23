From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 23 Oct 2014 14:19:01 +0300
Subject: Koelsch boot broken on 3.18-rc1 ?
In-Reply-To: <2292868.3VDUqTO9A7@avalon>
References: <10893192.WlcHQvfHhT@avalon>
 <CAMuHMdWydH0wrnkYSPgQqR19AN7pd1m+bD=Vwtv-EtPiSZ-6JA@mail.gmail.com>
 <2292868.3VDUqTO9A7@avalon>
Message-ID: <1859424.eZJcJgnv8e@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Thursday 23 October 2014 14:00:31 Laurent Pinchart wrote:
> On Thursday 23 October 2014 12:59:03 Geert Uytterhoeven wrote:
> > On Thu, Oct 23, 2014 at 12:53 PM, Laurent Pinchart wrote:
> >> While rebasing my rcar-dmac patches on top of 3.18-rc1 I ran into issues
> >> booting the Koelsch board.
> >> 
> >> Bisecting the problem pointed to
> >> 
> >> commit 95b0e655f9148881907fdbe5baba6a9f5d094fee
> >> Author: Marek Szyprowski <m.szyprowski@samsung.com>
> >> Date:   Thu Oct 9 15:26:49 2014 -0700
> >> 
> >>     ARM: mm: don't limit default CMA region only to low memory
> >> 
> >> With LPAE enabled this results in the sh-eth driver failing with
> >> 
> >> [    1.170000] irq 194: nobody cared (try booting with the "irqpoll"
> >> option)
> >> 
> >> and from time to time with an Address Error message as well (which got
> >> pushed out of my console log, I'll try to reproduce that again to get
> >> the exact message).
> > 
> > renesas-drivers-2014-10-23-v3.18-rc1 works on Koelsch for me, with LPAE.
> 
> I'll test it.

Both problems still occur for me with renesas-drivers-2014-10-23-v3.18-rc1. 
What kernel configuration do you use ?

-- 
Regards,

Laurent Pinchart
