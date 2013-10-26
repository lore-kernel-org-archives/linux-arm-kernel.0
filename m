From: w@1wt.eu (Willy Tarreau)
Date: Sun, 27 Oct 2013 00:11:03 +0200
Subject: Subsystem/interface for a 16x2 character LCD driver?
In-Reply-To: <87iowjrblq.fsf@natisbad.org>
References: <87iowjrblq.fsf@natisbad.org>
Message-ID: <20131026221103.GD28577@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

On Sat, Oct 26, 2013 at 11:00:49PM +0200, Arnaud Ebalard wrote:
> Hi,
> 
> I did not know where to ask but because it is related to an ARM
> platform, I decide to start here. NETGEAR ReadyNAS 104 has a front
> 16x2 characters backlight-capable LCD (Winstar WH1608). It is
> controlled via 11 GPIOS.
> 
> I am starting to write a driver for it to be able to pass messages (via
> /proc?) from userland to be displayed on the LCD and also enable/disable
> the backlight. I just wonder where it should go (auxdisplay? staging?
> video/backlight? drivers/misc?), if there are existing interfaces for
> such beasts and on which existing driver (if any) I could base my dev.
> 
> If you have any idea where/who I can ask, do not hesitate. Additionally,
> if someone has thoughts on what the DT interface should look like for
> such a device, I am interested.

You should probably take a look at the "panel" driver in staging. It's
a driver I wrote 10-15 years ago and that someone submitted. It supports
most 2-line text LCD panels with various wirings (serial/parallel), and
relies on parport to drive them. You can probably reuse some/most of it
for your driver. You may also possibly add a new backend to it to access
GPIOs. Userland drives it by writing into /dev/lcd. I don't know if that
can help.

Cheers,
Willy
