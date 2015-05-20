From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 20 May 2015 16:43:41 +0200
Subject: [PATCH v5 07/12] mtd: nand: add Samsung K9GBG08U0A-M to nand_ids
 table
In-Reply-To: <20150520142409.GP22054@kwain>
References: <1431356341-31640-1-git-send-email-antoine.tenart@free-electrons.com>
 <1431356341-31640-8-git-send-email-antoine.tenart@free-electrons.com>
 <555792FC.8030407@vanguardiasur.com.ar>
 <20150520140631.GN22054@kwain>
 <555C9584.1030609@vanguardiasur.com.ar>
 <20150520142409.GP22054@kwain>
Message-ID: <20150520144341.GQ22054@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 04:24:09PM +0200, Antoine Tenart wrote:
> On Wed, May 20, 2015 at 11:09:08AM -0300, Ezequiel Garcia wrote:
> > On 05/20/2015 11:06 AM, Antoine Tenart wrote:
> > > On Sat, May 16, 2015 at 03:57:00PM -0300, Ezequiel Garcia wrote:
> > >> On 05/11/2015 11:58 AM, Antoine Tenart wrote:

snip.

> > >> I found a datasheet here for K9GBG08U0A that claims to support JEDEC
> > >> device identification (i.e. 0x90 0x40 and 0xEC 0x40 commands). Have you
> > >> tested it? Any reason you are adding full ID instead?
> > > 
> > > This nand looks like another one defined in this file, so a full ID make
> > > sure the right parameters applies here.
> > > 
> > 
> > Oh, so you say the NAND detects the device ID and uses those parameters,
> > instead of doing the JEDEC detection?
> 
> I just had a look on the datasheet, and I you're right, the nand should
> support JDEC. However I get a "No NAND device found" error when
> reverting this patch.
> 
> It seems nand_flash_detect_jedec() is not reading "JDEC" and is returning
> directly. I'm having a look at this.

So, I can read 'J', 'E', 'D' and 'E' but then I got 0xff's. So I tried
to only check of JEDE in nand_flash_detect_jedec() but the JEDEC
parameter page was then not valid.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
