From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Nov 2015 19:51:48 +0000
Subject: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
In-Reply-To: <20151127132722.GA30871@n2100.arm.linux.org.uk>
References: <20150713131902.GH26485@atomide.com> <20151123144545.GD24147@pali>
 <20151125181644.GI2517@atomide.com> <17134653.86P3dFyQKK@wuerfel>
 <20151125210310.GT2517@atomide.com> <56568849.5080103@gmail.com>
 <20151126090739.GD14190@pali>
 <20151127132722.GA30871@n2100.arm.linux.org.uk>
Message-ID: <20151127195148.GB30871@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 01:27:23PM +0000, Russell King - ARM Linux wrote:
> It is possible to redirect any program to open any other file.  You can
> do it via a LD preload, and intercepting the open(), and possibly the
> read() calls if you want to do something more fancy.  The down-side is
> that you have to arrange for the preloaded object to be used by the
> linker, and the additional overhead it places on the intercepted
> functions.

Another idea if people don't like the preload idea.

We could create a zero-sized /proc/atags, and then use a bind mount in
userspace to bind some other file containing the required information
on top.  That could even be the atag blob from /sys/firmware/whatever.
The N700 (or whatever platform needs it) could be responsible for
creating the zero-sized /proc/atags so that we don't have it everywhere.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
