From: digetx@gmail.com (Dmitry Osipenko)
Date: Tue, 30 Jun 2015 16:56:54 +0300
Subject: [PATCH] ARM: tegra: paz00: set gpiod_lookup table conn_id's
In-Reply-To: <CAAVeFuKcaz1C9OV26+8A+LypScqDcufR+X99KDJwVui39Nq7xA@mail.gmail.com>
References: <1435520160-16862-1-git-send-email-digetx@gmail.com>
 <CAAVeFuKcaz1C9OV26+8A+LypScqDcufR+X99KDJwVui39Nq7xA@mail.gmail.com>
Message-ID: <5592A026.3010200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

30.06.2015 16:42, Alexandre Courbot ?????:
> On Mon, Jun 29, 2015 at 4:34 AM, Dmitry Osipenko <digetx@gmail.com> wrote:
>> Commit 72daceb9a10a ("net: rfkill: gpio: Add default GPIO driver mappings
>> for ACPI") removed possibility to request GPIO by table index for non-ACPI
>> platforms without changing it users. As result "shutdown" GPIO request
>> will fail if request for "reset" GPIO succeeded or "reset" will be
>> requested instead of "shutdown" if "reset" wasn't defined. Fix it by
>> setting conn_id's in gpiod_lookup_table.
>
> Yep, and using con_ids is a good idea anyway.
>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
>

After discussion on irc, turned out that patch missed 
s/GPIO_LOOKUP_IDX/GPIO_LOOKUP. I'll send V2.

And s/conn_id/con_id typo started to annoy me...

-- 
Dmitry
