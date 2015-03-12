From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Mar 2015 13:06:35 +0000
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <55005DC2.1060300@list.ru>
References: <54FF21BE.2040506@list.ru> <550038C9.7010807@free-electrons.com>
 <20150311131433.GC8656@n2100.arm.linux.org.uk>
 <550058BE.3060406@list.ru> <55005B81.9020103@free-electrons.com>
 <55005DC2.1060300@list.ru>
Message-ID: <20150312130635.GP8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 06:22:42PM +0300, Stas Sergeev wrote:
> 11.03.2015 18:13, Gregory CLEMENT ?????:
> > On 11/03/2015 16:01, Stas Sergeev wrote:
> >> 11.03.2015 16:14, Russell King - ARM Linux ?????:
> >>> On Wed, Mar 11, 2015 at 01:44:57PM +0100, Gregory CLEMENT wrote:
> >>>> Hi Stas,
> >>>>
> >>>> On 10/03/2015 17:54, Stas Sergeev wrote:
> >>>>> Hello, the patch below is needed for a successful boot on armada-xp.
> >>>>>
> >>>> I am really surprised by this patch because I used the Armada XP based
> >>>> board in a daily base and I never saw this issue.
> >>> Can you provide some details about your board - does it have 8GB of
> >>> memory, ranging from 0-0xf0000000, and 4G-8G ?
> >> I wonder about this 256Mb memory hole.
> > This is where the SoC registers are.
> OK but it seems I am loosing this region of _physical_ memory:

Correct, because the kernel can't see that physical memory.

If it tries to access the physical memory at those locations, it hits
the SoC registers and PCI instead of memory.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
