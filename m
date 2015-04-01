From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 1 Apr 2015 10:11:17 +0800
Subject: [PATCH v5 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
In-Reply-To: <20150331175234.GK9742@pengutronix.de>
References: <1426917922-61356-1-git-send-email-eddie.huang@mediatek.com>
 <1426917922-61356-3-git-send-email-eddie.huang@mediatek.com>
 <20150323084237.GG9742@pengutronix.de>
 <1427703252.26464.14.camel@mtksdaap41>
 <20150330172309.GB9742@pengutronix.de>
 <1427785715.3500.16.camel@mtksdaap41> <1427802658.32196.8.camel@mtksdaap41>
 <20150331175234.GK9742@pengutronix.de>
Message-ID: <1427854277.21285.15.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Tue, 2015-03-31 at 19:52 +0200, Sascha Hauer wrote:
> On Tue, Mar 31, 2015 at 07:50:58PM +0800, Eddie Huang wrote:
> > Hi Sascha,
> > 
> > On Tue, 2015-03-31 at 15:08 +0800, Eddie Huang wrote:
> > > Hi Sascha,
> > > 
> > > > > > speed <= 400000 here to make this more obvious?
> > > > > There are two cases, not only speed<=400000, but I2C_MASTER_WRRD. I tend
> > > > > to keep it.
> > > >
> > > > Still it looks strange. You only ever write this default value to the
> > > > register. Putting this register write under an if() seems bogus since
> > > > the same value will be in the register the next time this code is
> > > > executed. It looks like you should move this register write to some
> > > > initialization function.
> > > OK, move to mtk_i2c_init_hw function
> > > 
> > Sorry for my negligence. Write-then-read (I2C_MASTER_WRRD) decides
> > according to each I2C transfer, so I still need to judge whether set
> > I2C_CONTROL_RS and DELAY_LEN here. Other control setting can move to
> > init function.
> 
> You need to decide whether you have to set the I2C_CONTROL_RS bit, but
> you don't need to write the same value to the DELAY_LEN register each
> time. It won't change under your hood.
> 
Yes, you are right. DELAY_LEN should only be set one time in init
function. Thanks your correction.

Eddie
