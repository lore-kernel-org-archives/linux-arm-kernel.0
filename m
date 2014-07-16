From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Jul 2014 17:22:03 +0200
Subject: [PATCH 12/12] ARM: tegra: Convert PMC to a driver
In-Reply-To: <20140716151427.GA22027@ulmo>
References: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
 <17053542.QUGvfkeRmc@wuerfel> <20140716151427.GA22027@ulmo>
Message-ID: <6322144.IB6iKDb6TK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 July 2014 17:14:29 Thierry Reding wrote:
> > 
> > Ok, I'll have a look. I think when this becomes a separate driver, it
> > should also have its own header file, so maybe you can in the meantime
> > make it a local header file in mach-tegra until we have found a good
> > place for it.
> 
> Why do you think it should be a separate header? We already have a
> couple in include/linux and I'm not sure it's useful to add even more.
> If anything I would've thought it made sense to move the content of the
> other headers into tegra-soc.h.

I very much dislike the idea of having a per-vendor header file that
everything gets crammed into. We should try to have proper subsystems
and generic interfaces for these wherever possible.

	Arnd
