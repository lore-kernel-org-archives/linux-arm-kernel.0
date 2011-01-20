From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 20 Jan 2011 13:49:26 +0000
Subject: [PATCH] ux500: add a few AB8500 regulator consumers
In-Reply-To: <AANLkTins3Xgz+83cNJsoUY=KKfBdzWpMs7KFX05DpNfp@mail.gmail.com>
References: <1295269491-12107-1-git-send-email-linus.walleij@stericsson.com>
	<20110117132745.GA21113@opensource.wolfsonmicro.com>
	<AANLkTi=gsmiGFF31Si71LQBAZqpZZcxMDOK6e3xAyZV7@mail.gmail.com>
	<20110117153303.GK21113@opensource.wolfsonmicro.com>
	<AANLkTins3Xgz+83cNJsoUY=KKfBdzWpMs7KFX05DpNfp@mail.gmail.com>
Message-ID: <20110120134926.GG2551@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 10:11:16PM +0100, Linus Walleij wrote:

> If all AB8500 subdevices were to ask for regulators using the
> core device there would be just one big entry pointing
> to the ab8500-i2c.0 entry in this case, and a huge usecount,
> which is not helpful IMO. I like the detail.

It can make life easier from the point of view of setting stuff up since
you're not reliant on the internals of the MFD - for example, if you fix
the MFD to not create .0 devices you'll end up needing to update all the
users.

The supply names are generally relatively obvious.
