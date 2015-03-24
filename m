From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 24 Mar 2015 07:18:04 +0100
Subject: [RFC] pinmux: group and function definitions in the device tree
In-Reply-To: <20150323142954.GI32259@odux.rfo.atmel.com>
References: <20150319153950.GC30114@odux.rfo.atmel.com>
 <20150319185637.GV4927@pengutronix.de>
 <20150320150609.GB32259@odux.rfo.atmel.com>
 <20150323064424.GD9742@pengutronix.de>
 <20150323090827.GD32259@odux.rfo.atmel.com>
 <20150323100913.GJ9742@pengutronix.de>
 <20150323142954.GI32259@odux.rfo.atmel.com>
Message-ID: <20150324061804.GP9742@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 03:29:54PM +0100, Ludovic Desroches wrote:
> On Mon, Mar 23, 2015 at 11:09:13AM +0100, Sascha Hauer wrote:
> > On Mon, Mar 23, 2015 at 10:08:27AM +0100, Ludovic Desroches wrote:
> > > On Mon, Mar 23, 2015 at 07:44:24AM +0100, Sascha Hauer wrote:
> > > > On Fri, Mar 20, 2015 at 04:06:09PM +0100, Ludovic Desroches wrote:
> > > > > On Thu, Mar 19, 2015 at 07:56:37PM +0100, Sascha Hauer wrote:
> > > > > We used to have a configuration per pin in our products. On next ones we
> > > > > will have some constraints ie. on the controller side we still have a
> > > > > configuration per pin but we will introduced the notion of iosets. This
> > > > > notion involves that timings are guaranteed only in one ioset. That's
> > > > > why we can't mix signals from several iosets because. On the controller side
> > > > > we can do all we want so I would like to use groups as a software protection.
> > > > 
> > > > What does happen when you mix signals of different iosets? It won't work
> > > > so the developer will change it. What do you need the software
> > > > protection for?
> > > > 
> > > 
> > > I can't say it won't work, it could work in some cases. My fear is to
> > > have some support cases because of this. It seems easy to spot this kind
> > > of issue but experience tell us that we can loose time for this kind of
> > > "stupid" error.
> > 
> > Hm, the software (dts in this case) developer will only mix signals of
> > different iosets when he is forced to by the board designer. It's the
> > board designer that has made this mistake, the software developer will
> > only try to make it work anyway. I doubt that the board designer will
> > design the board based on the possibilities shown in the dts files.
> > 
> 
> I think we still have cases were the choice has to be done by the user.
> For example, the board designer offers several GPIOs, some can be muxed
> to the ISI device (there is two possible configurations). Among these pins, 
> we can use some of them for I2C devices.
> 
> The user will see that he could get two I2C devices by mixing ISI
> signals. Why not doing it. That's why I would like to keep some
> protection, a 'soft' protection such as group.

Even if you put groups in the dtsi, this won't prevent me from creating my own
groups in the board dts and thus still violating the ioset rule.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
