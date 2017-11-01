From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 1 Nov 2017 21:48:22 +0200
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <4b707ce0-6067-ab36-e167-1acf348d26bf@free.fr>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
 <20171101175325.2557ce85@alans-desktop>
 <4b707ce0-6067-ab36-e167-1acf348d26bf@free.fr>
Message-ID: <20171101194822.hd76z7zjazlqbsmy@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Wed, Nov 01, 2017 at 08:03:20PM +0100, Marc Gonzalez wrote:
> On 01/11/2017 18:53, Alan Cox wrote: 
> > For that matter given the bad blocks don't randomly change why not cache
> > them ?
> 
> That's a good question, I'll ask the NAND framework maintainer.
> Store them where, by the way? On the NAND chip itself?

Yes. In the bad block table (bbt). See drivers/mtd/nand/nand_bbt.c.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
