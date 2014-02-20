From: ijc@hellion.org.uk (Ian Campbell)
Date: Thu, 20 Feb 2014 11:39:16 +0000
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <20140220111913.GZ21483@n2100.arm.linux.org.uk>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-22-git-send-email-andrew@lunn.ch>
 <52F51922.6030502@gmail.com>
 <1392892217.23342.18.camel@kazak.uk.xensource.com>
 <20140220105854.GL11878@lunn.ch>
 <20140220111913.GZ21483@n2100.arm.linux.org.uk>
Message-ID: <1392896356.23342.40.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-02-20 at 11:19 +0000, Russell King - ARM Linux wrote:
> What's wrong with the soc subsystem (drivers/base/soc.c).  This
> provides a way to export SoC through standardised interfaces. 

It looks like the thing to use to me.

It seems to have been around only since v3.3 though, which makes it a
bit tricky to use when upgrading from running board-file based v3.2
system (Debian Wheezy) to a newer DTB based kernel, we need to select
the new DTB while running the old system.

I'd prefer to use this thing as the primary mechanism but it seems like
I'd have to implement some sort of fallback at least for one Debian
release cycle. I'm sure it is doable...

Ian.
