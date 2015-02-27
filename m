From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 27 Feb 2015 19:39:49 +0100
Subject: Bug in i2c-core?
In-Reply-To: <20150227174611.GC6679@dtor-ws>
References: <54F0507F.6030804@armadeus.com>
 <20150227153725.7404dea1@free-electrons.com>
 <6C8798CF-7222-465B-9354-93500B584B4D@gmail.com>
 <20150227170545.GS7789@pengutronix.de>
 <20150227174611.GC6679@dtor-ws>
Message-ID: <20150227183949.GT7789@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Feb 27, 2015 at 09:46:11AM -0800, Dmitry Torokhov wrote:
> On Fri, Feb 27, 2015 at 06:05:45PM +0100, Uwe Kleine-K?nig wrote:
> > On Fri, Feb 27, 2015 at 07:29:30AM -0800, Dmitry Torokhov wrote:
> > > On February 27, 2015 6:37:25 AM PST, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
> > > >Dear S?bastien SZYMANSKI,
> > > >
> > > >On Fri, 27 Feb 2015 12:09:51 +0100, S?bastien SZYMANSKI wrote:
> > > >
> > > >>         error = input_register_device(sx8654->input);
> > > >>         if (error)
> > > >>                 return error;
> > > >
> > > >Where is your ->remove() function that unregisters the input device?
> > > 
> > > Everything seems to be allocated with devm so remove is not needed.
> > Everything is devm_* but input_register_device, right?
> 
> Input is allocated with devm_* and input_register_device knows how to
> deal with that:
ah, something new each day. Thanks for teaching me.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
