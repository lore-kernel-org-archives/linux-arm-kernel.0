From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 06 Nov 2015 17:38:30 +0100
Subject: i.MX6: Oops when unplugging a USB key
In-Reply-To: <CAH-u=81BFm1nquN5z7hFN9auV=9dPMPkRFX_PneK22UXgPbJnA@mail.gmail.com>
References: <CAH-u=81BFm1nquN5z7hFN9auV=9dPMPkRFX_PneK22UXgPbJnA@mail.gmail.com>
Message-ID: <4306403.1Q6hpl8dCg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 November 2015 17:32:30 Jean-Michel Hautbois wrote:
> I have an issue on my i.MX6 board I don't understand (kernel is a 4.2)...
> When I connect a USB key, and then disconnect it, it oopses and
> reboots (as I have panic on oops, and reboot on panic).
> Seems to be on the umount part...
> The USB is connected through a smsc95xx but I don't think this is related...

You should normally unmount the file system before unplugging.

Did this work on other kernels? What happens if you unplug
that stick on your laptop while the file system is mounted?

	Arnd
