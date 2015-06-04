From: marex@denx.de (Marek Vasut)
Date: Thu, 4 Jun 2015 17:29:35 +0200
Subject: [PATCH 00/11] Enable access to SPI NOR flash on Samsung Snow board
In-Reply-To: <CAOMqctRkoQrP7wAgXfWXHb2fbi2-6VayHRx5DgUKn6Djz0qtQQ@mail.gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
 <201506040053.29482.marex@denx.de>
 <CAOMqctRkoQrP7wAgXfWXHb2fbi2-6VayHRx5DgUKn6Djz0qtQQ@mail.gmail.com>
Message-ID: <201506041729.35645.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 04, 2015 at 06:21:32 AM, Michal Suchanek wrote:
> On 4 June 2015 at 00:53, Marek Vasut <marex@denx.de> wrote:
> > On Wednesday, June 03, 2015 at 11:26:39 PM, Michal Suchanek wrote:
> >> Hello,
> > 
> > Hi,
> > 
> >> this patch series makes it possible to access the SPI NOR flash in the
> >> Samsung XE303 'Snow' Chromebook.
> >> 
> >> Unfortunately not all issues are resolved. To work around an issue with
> >> the pl330 dma engine I respun the patch for limiting transfer size in
> >> m25p80 driver.
> > 
> > Looks like fixing a bug at the wrong place to me ...
> > 
> >> As the flash does not contain any sane filesystem and is only likely to
> >> be accessed with mtd_debug or similar tool the limit of the dma engine
> >> is easily reached. Filesystems using shorter data transfers are less
> >> likely to be affected.
> > 
> > Sounds like the DMA engine driver should be fixed.
> 
> I looked at the pl330 datasheet and don't see anything obviusly wrong
> with the pl330 driver in Linux.
> 
> Ideally it would be fixed but I have no idea what's wrong with it.

Ask maybe Catalin from ARM to help you -- he might be able to point you
to the right hardware guy.

Best regards,
Marek Vasut
