From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 27 Jan 2013 15:53:53 +0100
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that kirkwood_ge0[01]_init()
 finds its clock
In-Reply-To: <20130127144610.GW1758@titan.lakedaemon.net>
References: <1359283223-23082-1-git-send-email-gmbnomis@gmail.com>
 <1359283223-23082-2-git-send-email-gmbnomis@gmail.com>
 <510506F9.3070500@gmail.com> <20130127110857.GA23687@schnuecks.de>
 <51053761.1020009@gmail.com> <20130127144610.GW1758@titan.lakedaemon.net>
Message-ID: <51053F81.6020904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2013 03:46 PM, Jason Cooper wrote:
>> I _cannot_ confirm that gbe is loosing its MAC address on Dove. I will
>> post a follow-up patch to Jason's cleanup patches that will also
>> grab a clock for smi. With that patch insmod'ing/rmmod'ing mv643xx_eth
>> does work just fine here on Dove.
>
> I believe Simon's issue is that the mv643xx_eth driver is not loaded at
> boot, it's clocks get gated, then when he loads the driver, there is no
> mac address.  Is that correct Simon?  I don't think unloading the driver
> after boot will trigger this regression.

Loading and unloading the driver module hangs because of the missing
clk_prepeare_enable in shared driver part. This should be fixed by the
patch I sent you.

Dove and Kirkwood have the same gbe internally and I can boot into Dove
without mv643xx_eth, load, unload, reload the module and it always finds
its MAC address.

I just want Simon to confirm that Kirkwood's gbe is really loosing the
contents of its MAC address registers during gated clocks, which is from
a HW point of view very unlikely.

Sebastian
