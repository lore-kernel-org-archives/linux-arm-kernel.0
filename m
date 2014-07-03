From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Jul 2014 20:07:42 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <15521199.3bNj4354Mf@wuerfel>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <4840595.cpHbY6hJKL@wuerfel> <20140703184626.GC21086@arm.com>
 <15521199.3bNj4354Mf@wuerfel>
Message-ID: <20140703190742.GE32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 08:53:06PM +0200, Arnd Bergmann wrote:
> It's certainly a very lengthy process. Just look at how long NWFPE has
> been in the kernel after it has become obsolete.

May I remind you that I still run OABI... and still use NWFPE here.
The machine which runs this mutt uses NWFPE with OABI.  The machine
that exim passes the message on to runs NWFPE with OABI.  The machine
which runs screen and irssi runs NWFPE with OABI.  The machine here
which operates as a print server runs NWFPE with OABI.  That's four
machines.

I did state at the time that I wanted there to be a way to migrate
easily from OABI to EABI - we sort of got that with the kernel's OABI
compat stuff, but it was ignored for userland, so there's no way that
I've been able to upgrade these machines (eg by adding an EABI glibc,
and recompiling the libraries/applications through gradual replacement),
and I don't have EABI platforms that can replace them.

What kernels do they run?

Linux pandora 3.12.6+ #28 Sun Dec 29 11:53:29 GMT 2013 armv5tel armv5tel armv5tel GNU/Linux
Linux n2100 3.1.8+ #15 Tue Nov 13 14:06:47 GMT 2012 armv5tel armv5tel armv5tel GNU/Linux
Linux flint 3.12.6+ #86 Tue Apr 1 12:25:44 BST 2014 armv4l armv4l armv4l GNU/Linux
Linux lists 3.9.0 #61 Tue May 14 19:35:42 BST 2013 armv4tl armv4tl armv4tl GNU/Linux

One of these is responsible for discovering the memory leak in the
raid code which no one else could find...

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
