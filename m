From: Wenyou.Yang@microchip.com (Wenyou.Yang at microchip.com)
Date: Tue, 19 Dec 2017 02:11:28 +0000
Subject: [PATCH v9 2/2] media: i2c: Add the ov7740 image sensor driver
In-Reply-To: <1641aa67-b05e-47e2-600c-70b77571b450@iki.fi>
References: <20171211013146.2497-1-wenyou.yang@microchip.com>
 <20171211013146.2497-3-wenyou.yang@microchip.com>
 <1641aa67-b05e-47e2-600c-70b77571b450@iki.fi>
Message-ID: <F9F4555C4E01D7469D37975B62D0EFBB8DDA56@CHN-SV-EXMX07.mchp-main.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sakari,

> -----Original Message-----
> From: Sakari Ailus [mailto:sakari.ailus at iki.fi]
> Sent: 2017?12?14? 4:06
> To: Wenyou Yang - A41535 <Wenyou.Yang@microchip.com>; Mauro Carvalho
> Chehab <mchehab@s-opensource.com>; Rob Herring <robh+dt@kernel.org>;
> Mark Rutland <mark.rutland@arm.com>
> Cc: linux-kernel at vger.kernel.org; Nicolas Ferre - M43238
> <Nicolas.Ferre@microchip.com>; devicetree at vger.kernel.org; Jonathan Corbet
> <corbet@lwn.net>; Hans Verkuil <hverkuil@xs4all.nl>; linux-arm-
> kernel at lists.infradead.org; Linux Media Mailing List <linux-
> media at vger.kernel.org>; Songjun Wu <songjun.wu@microchip.com>
> Subject: Re: [PATCH v9 2/2] media: i2c: Add the ov7740 image sensor driver
> 
> Hi Wenyou,
> 
> Wenyou Yang wrote:
> ...
> > +static int ov7740_start_streaming(struct ov7740 *ov7740) {
> > +	int ret;
> > +
> > +	if (ov7740->fmt) {
> > +		ret = regmap_multi_reg_write(ov7740->regmap,
> > +					     ov7740->fmt->regs,
> > +					     ov7740->fmt->reg_num);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	if (ov7740->frmsize) {
> > +		ret = regmap_multi_reg_write(ov7740->regmap,
> > +					     ov7740->frmsize->regs,
> > +					     ov7740->frmsize->reg_num);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return __v4l2_ctrl_handler_setup(ov7740->subdev.ctrl_handler);
> 
> I believe you're still setting the controls after starting streaming.

Yes, it sees it does so.

The OV7740 sensor generates the stream pixel data at the constant frame rate, no such start or stop control. 

> 
> --
> Sakari Ailus
> sakari.ailus at iki.fi

Wenyou Yang
-------------- next part --------------
A non-text attachment was scrubbed...
Name: imx7d-sdb.dtb
Type: application/octet-stream
Size: 46918 bytes
Desc: imx7d-sdb.dtb
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171219/361b8cf3/attachment-0001.obj>
