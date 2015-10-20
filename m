From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Tue, 20 Oct 2015 14:56:51 +0200
Subject: [PATCH] cpufreq: imx6: rework getting clocks and regulators
In-Reply-To: <20151020124731.GS14476@pengutronix.de>
References: <1445342218-12895-1-git-send-email-s.hauer@pengutronix.de>
 <1445344018.3716.16.camel@pengutronix.de>
 <20151020124731.GS14476@pengutronix.de>
Message-ID: <CAFSsGVtHaDkXDmnV4-X5z-2y48GM_erSWAYK-6bxR3wv4wHybg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 2:47 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Tue, Oct 20, 2015 at 02:26:58PM +0200, Lucas Stach wrote:
>> Am Dienstag, den 20.10.2015, 13:56 +0200 schrieb Sascha Hauer:
>> > Use devm_* functions for getting clocks and regulators. This simplfifies
>> > the error path. Also return the error from the failing call instead of
>> > collating all regulator and clock errors to -ENOENT. With this the
>> > driver can properly handle -EPROBE_DEFER. Handling deferred probing
>> > becomes necessary once the SoC internal regulators get supplies. While
>> > the SoC internal regulators are registered early in architecture code,
>> > the supplies may be regular I2C devices which may be probed after the
>> > cpufreq driver.
>> >
>> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>>
>> NACK
>>
>> This has come up several times before, maybe we should get a comment in
>> the code.
>
> Indeed, yes. This would help not wasting developing time.
>
> Anyway, the driver needs to handle -EPROBE_DEFER properly, if not with
> devm_ then without it.
>
About two days ago I sent two patches fixing this. Meanwhile Viresh
accepted them
so they should show up in the next kernel very soon.

> Sascha
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
