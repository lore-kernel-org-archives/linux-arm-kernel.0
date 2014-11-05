From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 5 Nov 2014 23:03:59 +0100
Subject: N900 modem support in 3.18-rc1
In-Reply-To: <201411052206.05379@pali>
References: <20141104205117.GA17606@amd> <201411052137.31452@pali>
 <20141105203918.GA29199@amd> <201411052206.05379@pali>
Message-ID: <20141105220359.GA32052@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Maybe you need to enable modem?
> 
> This is n900 init sequence from script: nokia-n900-configs.sh

>From the dts, it looks like this should somehow work without this.

I can try but.. is it safe? I'm using DT-based config, and interrupt
numbers definitely changed. If GPIO numbers changed, it will not be
funny.

Thanks,
									Pavel

>     # set up the GPIO's for N900 modem:
>     echo 70 >/sys/class/gpio/export
>     echo low >/sys/class/gpio/gpio70/direction
>     echo 0 >/sys/class/gpio/gpio70/value
>     echo 73 >/sys/class/gpio/export
>     echo high >/sys/class/gpio/gpio73/direction
>     echo 0 >/sys/class/gpio/gpio73/value
>     echo 74 >/sys/class/gpio/export
>     echo low >/sys/class/gpio/gpio74/direction
>     echo 75 >/sys/class/gpio/export
>     echo low >/sys/class/gpio/gpio75/direction
>     echo 157 >/sys/class/gpio/export
>     echo low >/sys/class/gpio/gpio157/direction
>     echo 0 >/sys/class/gpio/gpio157/value
>     # create symlinks for ofono N900 plugin
>     mkdir -p /dev/cmt
>     ln -nsf /sys/class/gpio/gpio70 /dev/cmt/cmt_apeslpx
>     ln -nsf /sys/class/gpio/gpio74 /dev/cmt/cmt_en
>     ln -nsf /sys/class/gpio/gpio73 /dev/cmt/cmt_rst_rq
>     ln -nsf /sys/class/gpio/gpio75 /dev/cmt/cmt_rst
>     ln -nsf /sys/class/gpio/gpio157 /dev/cmt/cmt_bsi
> 



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
