From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 04 Aug 2014 19:43:22 +0200
Subject: [PATCH v6 00/10] ARM: dts: exynos: Prepare Spring
In-Reply-To: <CAD=FV=WFNW_5KZvLMk0kK1JQsdWLeo2kCjpQsFuxKNSnOKzfgw@mail.gmail.com>
References: <1406940750-15880-1-git-send-email-afaerber@suse.de>	<53DC4E41.4050200@collabora.co.uk>	<CAD=FV=V_vXZLMaTMFdgr62=zRXucZA6D3PvS0Mb40he0ShHTfA@mail.gmail.com>	<53DCBC84.8080600@suse.de>
 <CAD=FV=WFNW_5KZvLMk0kK1JQsdWLeo2kCjpQsFuxKNSnOKzfgw@mail.gmail.com>
Message-ID: <53DFC63A.7010709@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On 08/04/2014 05:42 PM, Doug Anderson wrote:
> 
> 
>> Both of you mentioned limitations of cros_ec i2c passthrough leading to
>> a forked tps65090 driver downstream - I don't think I can be of help
>> there, as I guess simply copying a driver will not be an option. ;)
>> https://code.google.com/p/chromium/issues/detail?id=391797
> 
> Yup, I think this will be real work for someone.  I made a quick
> attempt and failed at it and I haven't had time to work on it since
> (and don't necessarily expect to have time in the near future)...  I
> think it is possible for anyone versed in i2c to figure this out based
> on what I already posted and what's in our local tree...
> 

I posted a series [0] with the remaining cleanups/fixes for cros_ec that are on
the downstream Chrome OS 3.8 kernel. Once these lands it will be easier to add
the missing cros_ec functionality on top. I've these on my TODO list but I was
going to give priority to the cros_ec user-space interface, LPC bus support and
vboot context over the tps65090 Spring support since I don't have access to a
Spring machine to test.

> 
>> For the touchpad it seems DT support has landed in the input tree as
>> "atmel,maxtouch". Backporting just that patch does not make it work
>> though. (Tried the rejected pinctrl approach to be on the safe side.)
>> https://code.google.com/p/chromium/issues/detail?id=371114
>> https://patchwork.kernel.org/patch/3976801/
> 
> This is the same work as needed for pit and pi, I believe.  Perhaps
> Javier or Dmitry has this on their todo list?
> 
> 

Yes, I've this on my TODO list as well.

Best regards,
Javier

[0]: http://www.spinics.net/lists/linux-samsung-soc/msg34897.html
