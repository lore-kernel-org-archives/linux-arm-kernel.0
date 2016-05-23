From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 23 May 2016 18:38:31 -0300
Subject: Crash after 'reboot' due to 9be4fd2c7723a
In-Reply-To: <20160523210738.GZ19428@n2100.arm.linux.org.uk>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
 <CAJZ5v0hX1dZ+79-KCyumf57o02WKivxcRLJ1Zi8akrqu_2CZEQ@mail.gmail.com>
 <CAOMZO5CD08cX0yDBZTdFV+iwgr__fjSaaWvgjimotr5L1yrbaQ@mail.gmail.com>
 <2148724.oQlEHos3jS@vostro.rjw.lan>
 <20160523182807.GY19428@n2100.arm.linux.org.uk>
 <CAJZ5v0ipPVsZmu+RVfrPChA7banMGFNsfMt=if0V3XfVdstRNQ@mail.gmail.com>
 <CAJZ5v0j0VbyHNT_ZmThsdQfRWzf7SG65A8-bPxoAUxZJgR96og@mail.gmail.com>
 <CAOMZO5Cbue9L2JGA0kv7nTZ=78oKDhNu6WLRUmcsSuLHscDVUQ@mail.gmail.com>
 <20160523210738.GZ19428@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5DjjgNk+uHyH7Avvfrt_TNPaZ+SUtHzON5fPU=25_gKOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2016 at 6:07 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> Read the code again.  There's three states:
>
> 1. CONFIG_SMP=n - it always returns false.
> 2. CONFIG_SMP=y, CONFIG_SMP_ON_UP=n - it always returns true.  Such a
>    kernel can _only_ be run on SMP capable systems.
> 3. CONFIG_SMP=y, CONFIG_SMP_ON_UP=y - it returns depending on whether
>    we detect that the CPU is SMP capable.

Yes, I meant that on imx6ul we have option 2 above with imx_v6_v7_defconfig.

Also tested option 3 and is_smp() returns true as well.

I will try to see why GIC on this SoC cannot work in SMP.
