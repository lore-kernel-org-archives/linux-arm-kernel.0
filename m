From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 11 Jun 2013 09:39:31 +0800
Subject: [PATCH] reset: provide dummy API entries to avoid link errors
In-Reply-To: <51B5F970.1080505@wwwdotorg.org>
References: <1370755846-27011-1-git-send-email-Baohua.Song@csr.com>
 <51B5F970.1080505@wwwdotorg.org>
Message-ID: <CAGsJ_4xY4anEme-S1AvE5aDf_R5zPmx7wzHM=rmRRxgqFiqR3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/6/11 Stephen Warren <swarren@wwwdotorg.org>:
> On 06/08/2013 11:30 PM, Barry Song wrote:
>> this patch provides dummy reset API entries like other subsystem e.g.
>> gpiolib to avoid link errors when RESET_CONTROLLER is not enabled.
>
> I would tend to think that any driver that needs to use this API to
> reset its HW should depend on the reset API (or select it) to ensure
> that the API was present.
>
> That way, problems would be detected at compile-time, not run-time.

Hi Stephen,
your point is right if the hardware IP always need a real reset to
work. but the current situation is that many common IP can be used in
many chips. in some chips, the designer might provide a reset
controller with a bit set to reset this IP module, but in some other
chips, there can be no. so a common driver for this IP should be able
to work with calling device_reset even while lacking of
RESET_CONTROLLER. here we are considering a case for chipidea,
ci13xxx, there is a reset bit for it on sirf, but it seems these is no
code showing a reset bit exists for imx.

>

-barry
