From: jon.nettleton@gmail.com (Jon Nettleton)
Date: Tue, 17 Nov 2015 10:38:13 +0100
Subject: Freescale IMX6 active cooling
In-Reply-To: <CAOMZO5AX9owvovpdmdr=rKNApbuNrkp9pKexJk_mMyMdH1=1qg@mail.gmail.com>
References: <CABH3fy-He02iVU7FzqcPApPemeoqQP15+gr9+Hx87-OEBuHvCg@mail.gmail.com>
 <CAOMZO5AX9owvovpdmdr=rKNApbuNrkp9pKexJk_mMyMdH1=1qg@mail.gmail.com>
Message-ID: <CALHpu37MNnzW=3YNKUq-aOHgF12EhjyN7g1juTwuMad_Xv891w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 3:51 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Nov 16, 2015 at 7:43 AM, Catalin Crenguta
> <catalin.crenguta@gmail.com> wrote:
>> Hello,
>>
>> I'm trying to use a GPIO Fan to cool down a Riotboard (I.MX6 Solo).
>> I've read [0], investigated the driver which provides the on-die
>> temperature ( fsl,imx6q-tempmon [1]) but it seems to provide the
>> temperature by creating a thermal zone (relevant dts: [2][3][4]).
>> I don't know how I should proceed:
>> 1) Should I research how can I attach a cooling device to this already
>> existing thermal zone? (I believe it involves modifying the existing
>> driver by adding new device tree handles)
>> 2) Should I create another thermal zone, use the existing driver to
>> get the temperature and bind to a cooling device?
>> 3) Should I modify the existing driver to not create a thermal zone
>> and move the creation in the device tree using the of-thermal driver ?
>
> Maybe you could add the following folks on Cc?
>
> THERMAL/CPU_COOLING
> M:    Amit Daniel Kachhap <amit.kachhap@gmail.com>
> M:    Viresh Kumar <viresh.kumar@linaro.org>
> M:    Javi Merino <javi.merino@arm.com>
> L:    linux-pm at vger.kernel.org
> S:    Supported
> F:    Documentation/thermal/cpu-cooling-api.txt
> F:    drivers/thermal/cpu_cooling.c
> F:    include/linux/cpu_cooling.h
>
> _______________________________________________

I would recommend you take a look at the work that xobs did for the
Novena Heirloom.  If you look at this branch starting around Aug 3 you
can see where he has converted iMX6 to use generic thermal zones and
adds support for for an active cooling device/fan.
https://github.com/xobs/novena-linux/commits/v3.19-novena-etnadrm-r3?page=3

-Jon
