From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 28 Feb 2014 13:57:36 +0100
Subject: [PATCH 0/9] Doc/DT: DT bindings for various display components
In-Reply-To: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <531087C0.1090501@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/14 13:20, Tomi Valkeinen wrote:
> This series is a re-send of
> http://article.gmane.org/gmane.linux.drivers.devicetree/61739
>
...
> Shortly about the display components in the series, in the order of probable
> public interest:
>
> * Analog TV, DVI and HDMI Connectors represent a respective connector on the
>    board. They don't do much, but they do mark the end of the video pipeline (from
>    the board's pov), and they should also in the future offer ways to handle
>    things like the +5V pin on DVI and HDMI connector and HPD pin.
>
> * MIPI DPI panel and MIPI DSI CM panels represent bindings for simple panels
>    using the respective video bus.
>
> * Sony acx565akm is an SPI controlled panel using flatlink video bus.
>
> * TFP410 is a DPI to DVI encoder.
>
> * TPD12S015 is a HDMI companion chip, used on OMAP boards.

Tomi,

Out of curiosity, will there be DT nodes for pull-up resistors soon,
too? ;)

Honestly, TPD12S015 is a level shifter, there is nothing in it that
would justify a DT node nor a driver.

Above you already note, that connector nodes should offer HPD in the
future, but I guess the binding should represent that now already.
I will be a DT stub anyway, the corresponding video sink driver will
have to look it up.

Looking through the bindings for DVI and HDMI, I guess HPD gpio is
better kept in those nodes. From the relevant (DT) properties DVI and
HDMI connectors are in no way different.

Sebastian
