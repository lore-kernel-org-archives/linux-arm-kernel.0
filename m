From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 20 Mar 2014 11:54:52 -0700
Subject: [PATCH 2/3] mtd: davinci-nand: add dts property for
 NAND_NO_SUBPAGE_WRITE option
In-Reply-To: <532B2D3F.6050004@ti.com>
References: <1395335184-4745-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1395335184-4745-3-git-send-email-ivan.khoronzhuk@ti.com>
 <532B2183.2080309@ti.com>
 <20140320172912.GW31517@norris-Latitude-E6410>
 <532B2766.6090506@ti.com>
 <D69011BE-C37F-4085-B992-45F6F32AF1D0@gmail.com>
 <532B2D3F.6050004@ti.com>
Message-ID: <20140320185452.GB21018@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 02:02:39PM -0400, Santosh Shilimkar wrote:
> On Thursday 20 March 2014 01:44 PM, Warner Losh wrote:
> > I though sub page writing was one of the fields in the onfi and/or jedec(toggle) meta data structures. Have you looked there?
> > 
> Am not sure if I follow you. The limitation is from the TI NAND controller(AEMIF) and
> not the NAND memory. 

That doesn't match the patch description, which says "that flash doesn't
support subpage writing". Flash != flash controller.

Which one is it? If it's a controller limitation, I think we should be
able to pull this from a "compatible" property, no?

Brian
