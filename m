From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 10 Sep 2014 15:15:05 +0200
Subject: [PATCH] ARM: DT: imx53: fix lvds channel 1 port
In-Reply-To: <20140910012831.GB2341@dragon>
References: <1409848985-16140-1-git-send-email-list-09_linux_arm@tqsc.de>
 <20140910012831.GB2341@dragon>
Message-ID: <1410354905.4508.21.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Am Mittwoch, den 10.09.2014, 09:28 +0800 schrieb Shawn Guo:
> On Thu, Sep 04, 2014 at 06:43:05PM +0200, Markus Niebel wrote:
> > From: Markus Niebel <Markus.Niebel@tq-group.com>
> > 
> > using LVDS channel 1 on an i.MX53 leads to following error:
> > 
> > imx-ldb 53fa8008.ldb: unable to set di0 parent clock to ldb_di1
> > 
> > This comes from imx_ldb_set_clock with mux = 0. Mux parameter must be "1" for
> > reparenting di1 clock to ldb_di1. The value of the mux param comes from device
> > tree port settings.
> > 
> > On i.MX5, the internal two-input-multiplexer is used. Due to hardware limitations,
> > only one port (port@[0,1]) can be used for each channel (lvds-channel@[0,1],
> > respectively)
> > 
> > Documentation update suggested by Philipp Zabel <p.zabel@pengutronix.de>
> > 
> > Signed-off-by: Markus Niebel <Markus.Niebel@tq-group.com>
> 
> Philipp,
> 
> Does the patch look good to you?  I feel more comfortable to send it as
> a fix and stable material only with your ACK at this stage.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
