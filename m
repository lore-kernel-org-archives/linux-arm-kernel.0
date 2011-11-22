From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 22 Nov 2011 12:19:51 -0800
Subject: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
In-Reply-To: <9315670.oOZAWsuHPb@wuerfel>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <CAPtuhTheG-mvoGMaB2y9BSKF-abm2yigoN-SXaeCb+P5R6t_Dg@mail.gmail.com>
 <CACxGe6vK-vHvSbd9N2k3FZY4gGVS_DETx0BbfPgNghTkOncjpg@mail.gmail.com>
 <9315670.oOZAWsuHPb@wuerfel>
Message-ID: <CAJOA=zOp3o=bdryFbz6LVQF5fxPvhVWKme_GD3fyQr7=-n2E_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 12:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 22 November 2011 12:19:51 Grant Likely wrote:
>> On Tue, Nov 22, 2011 at 11:01 AM, Mike Turquette <mturquette@linaro.org> wrote:
>>
>> > Others have requested to have knobs made available for actually
>> > performing clk_enable/clk_disable and even clk_set_rate from
>> > userspace. ?I hate this idea and won't implement it. ?I encourage
>> > anyone that needs this to do it in debugfs.
>> >
>> > Does that work-split make sense to you, or do you still not like the
>> > idea of having topology and read-only info in sysfs?
>>
>> Unless there is a solid real-world use case for exporting this data to
>> userspace, I do not think sysfs is a good idea. ?As long as the usage
>> (beyond debug) is theoretical I think the whole thing should be in
>> debugfs. ?It can always be moved at a later date If a real use case
>> does become important.
>
> I would recomment not to spend any time on implementing a debugfs interface
> for this right now. As far as I can tell, nothing relies on exporting
> the structure to user space, so Mike's time is better spent on getting the
> other four patches merged.

Seems to be some consensus on this.  Will drop userspace-visible clk
tree from V4 patchset.

Regards,
Mike

>
> Note that the static topology information about clocks will already be
> visible in /proc/devicetree when that is enabled and the clocks are
> described in the .dts file.
>
> ? ? ? ?Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
