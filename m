From: Robin.Getz@analog.com (Getz, Robin)
Date: Fri, 13 Sep 2013 20:57:51 +0000
Subject: [PATCH 27/38] iio: pressure-core: st: Give some indication if
 device probing was successful
In-Reply-To: <20130911072955.GG11227@lee--X1>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-28-git-send-email-lee.jones@linaro.org>
 <43055af7-991f-4122-b308-a3dcddbbb72a@email.android.com>
 <20130911071053.GD11227@lee--X1> <52301963.5030006@metafoo.de>
 <20130911072955.GG11227@lee--X1>
Message-ID: <FEAE1C531EE4684EBDD22603EC8BE59931CAB11B@NWD2MBX7.ad.analog.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 11, 2013 3:30 AM Lee Jones wrote:
> On Wed, 11 Sep 2013, Lars-Peter Clausen wrote:
> > On 09/11/2013 09:10 AM, Lee Jones wrote:
> > >On Tue, 10 Sep 2013, Jonathan Cameron wrote:
> > >>Lee Jones <lee.jones@linaro.org> wrote:
> > Silence means everything is good, a message means there is an error.
> > If every device that gets probed would spit out a message the log
> > would be scrolling forever and you wouldn't be able to see the error
> > messages.
> 
> Only if you print out every regulator, clock, GPIO pin and things of this nature.
> Key hardware blocks such as; SD, Flash, USB, Eth, HDMI, Audio, UART, GPIO and
> I2C controllers and Sensors I think deserve a one line "I'm here and working"
> message.

In many embedded systems -- there are lots and lots of IIO devices, and I'm not sure 
I would consider very many "key". It really depends on the board.

To me it's a matter of boot time. Even memcpy to msgbuf takes time.
Sometimes unnecessary time.

> I'll not fight this for too long. This is based my experience as a user. I tried to
> look at the bootlog for the sensors I'd just enabled and there was nothing. Some
> of them had probed, some hadn't and there was no clear way to distinguish
> between them without digging into sysfs.

echo "working:"
cat /sys/bus/iio/devices/*/name

isn't too much digging. If you really want to do that on your machine - do so in rc.local

for many other subsystems, it's just not that easy, and printing from the driver is necessary.

-Robin
