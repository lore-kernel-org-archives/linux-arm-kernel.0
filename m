From: joshua.clayton@uniwest.com (Joshua Clayton)
Date: Fri, 06 Nov 2015 11:12:39 -0800
Subject: i.MX6: Oops when unplugging a USB key
In-Reply-To: <CAH-u=81BFm1nquN5z7hFN9auV=9dPMPkRFX_PneK22UXgPbJnA@mail.gmail.com>
References: <CAH-u=81BFm1nquN5z7hFN9auV=9dPMPkRFX_PneK22UXgPbJnA@mail.gmail.com>
Message-ID: <2393919.Res6zC5Fd5@jclayton-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, November 06, 2015 05:32:30 PM Jean-Michel Hautbois wrote:
> Hi !
> 
> I have an issue on my i.MX6 board I don't understand (kernel is a 4.2)...
> When I connect a USB key, and then disconnect it, it oopses and
> reboots (as I have panic on oops, and reboot on panic).
> Seems to be on the umount part...
> The USB is connected through a smsc95xx but I don't think this is related...
> 
> Any idea is welcome :)
> 

I have seen a similar issue intermitently on my imx6 based board.
I would also like to find a fix.

Specifically: unplugging usb storage occasionally causes an oops.

I'm guessing a race with use-after-free, but I haven't tracked it down.
In my environment it has been hard to reproduce, and I wasn't able to
grok anything useful in the trace.

Are you seeing this behavior consistently?

Perhaps the driver is freeing more than it should when a device is disconnected.

-- 
Joshua Clayton
Software Engineer
UniWest
122 S. 4th Avenue
Pasco, WA 99301
(509) 544-0720
