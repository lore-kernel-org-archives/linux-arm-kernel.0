From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 10 May 2016 13:52:58 +0200
Subject: [PATCH 0/2] mtd: atmel_nand: remove compatible "atmel,sama5d4-nfc"
In-Reply-To: <B256D81BAE5131468A838E5D7A243641D6487F5A@penmbx01>
References: <1462776680-5284-1-git-send-email-wenyou.yang@atmel.com>
 <20160509201324.GA9845@rob-hp-laptop>
 <B256D81BAE5131468A838E5D7A243641D6487F5A@penmbx01>
Message-ID: <20160510115258.GS2890@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/2016 at 04:50:37 +0000, Yang, Wenyou wrote :
> 
> 
> > -----Original Message-----
> > From: Rob Herring [mailto:robh at kernel.org]
> > Sent: 2016?5?10? 4:13
> > To: Yang, Wenyou <Wenyou.Yang@atmel.com>
> > Cc: Brian Norris <computersforpeace@gmail.com>; David Woodhouse
> > <dwmw2@infradead.org>; Pawel Moll <pawel.moll@arm.com>; Mark Brown
> > <broonie@kernel.org>; Ian Campbell <ijc+devicetree@hellion.org.uk>; Kumar
> > Gala <galak@codeaurora.org>; linux-kernel at vger.kernel.org; linux-
> > mtd at lists.infradead.org; devicetree at vger.kernel.org; Ferre, Nicolas
> > <Nicolas.FERRE@atmel.com>; Alexandre Belloni <alexandre.belloni@free-
> > electrons.com>; Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>;
> > Russell King <linux@arm.linux.org.uk>; Josh Wu <rainyfeeling@outlook.com>;
> > linux-arm-kernel at lists.infradead.org
> > Subject: Re: [PATCH 0/2] mtd: atmel_nand: remove compatible "atmel,sama5d4-
> > nfc"
> > 
> > On Mon, May 09, 2016 at 02:51:17PM +0800, Wenyou Yang wrote:
> > > It is a datasheet bug, for current SoCs, the RB_EDGE3(i.e. bit 27) of
> > > HSMC_SR register does not exist, the RB_EDGE0 (i.e. bit 24) is the
> > > ready/busy line edge status bit. So the compatible "atmel,sama5d4-nfc"
> > > is unneeded.
> > 
> > The compatible is needed if the SOC still exists. You can list both for the sama5d4
> > if the block is the same.
> 
> The NFC IP of SAMA5D4 is same as SAMA5D2's, SAMA5D4 hase this issue.  This compatible can be removed. 
> 

Well, I agree with Rob, we don't remove an existing compatible. Simply
make it do the right thing (i.e. the same as sama5d3-nfc).

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
