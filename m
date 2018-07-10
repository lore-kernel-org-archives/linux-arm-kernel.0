From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 10 Jul 2018 12:11:47 +0200
Subject: Vibrations on Droid 4?
In-Reply-To: <20180709220211.GA7760@amd>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
Message-ID: <20180710101147.lyu65ro4czvrs2da@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 10, 2018 at 12:02:11AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Do you have vibrations on d4 working?
> > > I believe I have required drivers enabled, but no luck:
> > > 
> > > user at devuan:/sys/bus/platform/drivers$ ls pwm-vibrator/
> > > bind  uevent  unbind
> > > user at devuan:/sys/bus/platform/drivers$ ls omap-dmtimer-pwm/
> > > bind  uevent  unbind
> > 
> > Have you checked probe deferrals?
> 
> Not really. Is there easier way to do that than adding printks in the
> probe function? (I can go through dmesg tommorow).

Option 1: https://lkml.org/lkml/2018/7/8/63

Option 2: dynamic debug via kernel commandline (needs CONFIG_DYNAMIC_DEBUG)

dyndbg="func deferred_probe_work_func +p; func driver_deferred_probe_add +p"

Option 3: use "initcall_debug" kernel commandline

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180710/c71e49f3/attachment-0001.sig>
