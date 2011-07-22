From: khilman@ti.com (Kevin Hilman)
Date: Fri, 22 Jul 2011 12:51:06 -0700
Subject: [PATCH] OMAP: omap_device: replace pr_* prints with dev_*
In-Reply-To: <CANOLnOOAJMyHUjrf_cM2LVSAs6Zm2bK3RWK73ibNcVg=7vQP4w@mail.gmail.com>
	(Grazvydas Ignotas's message of "Fri, 22 Jul 2011 16:15:27 +0300")
References: <1311269976-4035-1-git-send-email-khilman@ti.com>
	<CANOLnOOAJMyHUjrf_cM2LVSAs6Zm2bK3RWK73ibNcVg=7vQP4w@mail.gmail.com>
Message-ID: <87hb6e2ixh.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grazvydas Ignotas <notasas@gmail.com> writes:

> On Thu, Jul 21, 2011 at 8:39 PM, Kevin Hilman <khilman@ti.com> wrote:
>> ? ? ? ? ? ? ? ?if (act_lat > odpl->activate_lat) {
>> ? ? ? ? ? ? ? ? ? ? ? ?odpl->activate_lat_worst = act_lat;
>> ? ? ? ? ? ? ? ? ? ? ? ?if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?odpl->activate_lat = act_lat;
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? pr_warning("omap_device: %s.%d: new worst case "
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"activate latency %d: %llu\n",
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?od->pdev.name, od->pdev.id,
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?od->pm_lat_level, act_lat);
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dev_warn(&od->pdev.dev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"new worst case activate latency "
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"%d: %llu\n",
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?od->pm_lat_level, act_lat);
>
> I wonder why these have to be warnings, I get quite a lot of them and
> find them rather annoying. Or is my hardware broken or something?

No, your hardware is not broken.

> I know other people are disabling this in their trees too:
> http://www.sakoman.com/cgi-bin/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=145cf9a7d4ba7c260df7071a28ef40c6a481b6df

Patches to change that are welcome on the list.  

It's not related to this patch which just changes from pr_warning to
dev_warn, so needs to be done in a separate patch.

Kevin
