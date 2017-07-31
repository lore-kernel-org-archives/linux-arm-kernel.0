From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 31 Jul 2017 08:13:10 +0300
Subject: [PATCH v2 1/3] media: V3s: Add support for Allwinner CSI.
In-Reply-To: <20170731094806.88c3188576d7e2c14b5e3e33@magewell.com>
References: <1501131697-1359-1-git-send-email-yong.deng@magewell.com>
 <1501131697-1359-2-git-send-email-yong.deng@magewell.com>
 <20170728160233.xooevio4hoqkgfaq@flea.lan>
 <20170730060801.bkc2kvm72ktixy74@tarshish>
 <20170731094806.88c3188576d7e2c14b5e3e33@magewell.com>
Message-ID: <20170731051310.jp45cj7lugcueztc@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

On Mon, Jul 31, 2017 at 09:48:06AM +0800, Yong wrote:
> On Sun, 30 Jul 2017 09:08:01 +0300
> Baruch Siach <baruch@tkos.co.il> wrote:
> > On Fri, Jul 28, 2017 at 06:02:33PM +0200, Maxime Ripard wrote:
> > > On Thu, Jul 27, 2017 at 01:01:35PM +0800, Yong Deng wrote:
> > > > +	regmap_write(sdev->regmap, CSI_CH_F0_BUFA_REG,
> > > > +		     (bus_addr + sdev->planar_offset[0]) >> 2);
> > 
> > Why do you need the bit shift? Does that work for you?
> > 
> > The User Manuals of both the V3s and the and the A33 (AKA R16) state that the 
> > BUFA field size in this register is 31:00, that is 32bit. I have found no 
> > indication of this bit shift in the Olimex provided sunxi-vfe[1] driver. On 
> > the A33 I have found that only after removing the bit-shift, (some sort of) 
> > data started to appear in the buffer.
> > 
> > [1] https://github.com/hehopmajieh/a33_linux/tree/master/drivers/media/video/sunxi-vfe
> 
> The Users Manuals do not document this bit shift. You should see line 10 to
> 32 in https://github.com/hehopmajieh/a33_linux/blob/master/drivers/media/video/sunxi-vfe/csi/csi_reg.c

Thanks. So for my reference, the SoCs that don't need bit shift are A31, A23, 
and A33. SoCs that need bit shift are A80, A83, H3, and V3s (AKA V30).

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
