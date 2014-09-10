From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 10 Sep 2014 11:55:31 +0300
Subject: [periperi] How to set default GPIO pin ?
In-Reply-To: <8738cc0vx9.wl%kuninori.morimoto.gx@gmail.com>
References: <8738cc0vx9.wl%kuninori.morimoto.gx@gmail.com>
Message-ID: <2862746.g5u9pdpKDi@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Morimoto-san,

(Moving this thread to linux-sh and linux-arm and CC'ing Linus Walleij)

On Sunday 31 August 2014 22:08:52 Kuninori Morimoto wrote:
> 
> I know we can use "defalt" PFC settings on DT.
> But, how to use "defalt" GPIO pin settings on DT ?
> 
> We would like to use GPIO 7-17 as Low output,
> and do nothing after boot.

>From a DT point of view I believe this is supposed to be done by specifying 
the output-low or output-high properties in the pinctrl configuration node. 
However, these properties are not supported by the PFC driver, and there's no 
easy way for the PFC driver to configure GPIOs handled by a different driver 
such as the gpio-rcar driver for instance.

Linus, do you have any hindsight on how this should be implemented ?

-- 
Regards,

Laurent Pinchart
