From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 24 Jan 2017 15:39:27 -0800
Subject: [PATCH 6/9] power_supply: wm97xx_battery: use
 power_supply_get_drvdata
In-Reply-To: <20170124204011.GH27969@dtor-ws> (Dmitry Torokhov's message of
 "Tue, 24 Jan 2017 12:40:11 -0800")
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
 <1477510907-23495-7-git-send-email-robert.jarzmik@free.fr>
 <CAOi56cVk17w6C6msnT88c0Zh1OgLM=FbZAw32MzLRatjFraYhg@mail.gmail.com>
 <87h94odic0.fsf@belgarion.home> <20170124204011.GH27969@dtor-ws>
Message-ID: <m27f5k1100.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> On Tue, Jan 24, 2017 at 08:31:59AM +0100, Robert Jarzmik wrote:
>> Kevin Hilman <khilman@kernel.org> writes:
>> 
>> > Hello,
>> >
>> > On Wed, Oct 26, 2016 at 12:41 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> >> As the power supply framework provides a way to store and retrieve
>> >> private supply data, use it.
>> >>
>> >> In the process, change the platform data for wm97xx_battery from a
>> >> container of a single struct wm97xx_batt_pdata to the direct point to wm97xx_batt_pdata.
>> >>
>> >> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> >
>> > kernelci.org has been reporting that the tegra20-iris board has been
>> > failing in -next since next-20161123[1], and also in mainline
>> > v4.10-rc.  I finally took the time to bisect, and it pointed to this
>> > patch.  I verified that reverting $SUBJECT patch[2] on top of
>> > v4.10-rc5 fixes the problem.
>> >
>> > Kevin
>> >
>> > [1] https://kernelci.org/boot/id/5879a3fe59b5141534f6c3ac/
>> > [2] in mainline as commit: 6480af4915d6 power_supply: wm97xx_battery:
>> > use power_supply_get_drvdata
>> 
>> Hi Kevin,
>> 
>> There is a fix posted in here :
>> https://patchwork.kernel.org/patch/9499231/
>> 
>> I don't know if it's related, as I have no Oops signature nor any data to be
>> able to help further.

FWIW, that kernelci.org link above has full boot log available:
https://storage.kernelci.org/next/next-20170113/arm-tegra_defconfig/lab-baylibre-seattle/boot-tegra20-iris-512.html

> I picked up the patch from patchwork and will send it on to Linus in the
> next day or so.

I tested this on top of linus/master and the boot failure goes away.

Feel free to add,

Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin
