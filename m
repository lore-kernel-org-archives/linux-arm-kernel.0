From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Thu, 16 Dec 2010 08:21:54 -0600
Subject: [PATCH v4 4/5] OMAP: mailbox: build device using
	omap_device/omap_hwmod
In-Reply-To: <20101216084446.GB10883@n2100.arm.linux.org.uk>
References: <1292482079-2226-1-git-send-email-omar.ramirez@ti.com>
	<1292482079-2226-5-git-send-email-omar.ramirez@ti.com>
	<AANLkTik4K3LEovr-wJiv_PG+ivHNj8hxPT7QPua-ytVf@mail.gmail.com>
	<20101216084446.GB10883@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=VyX4M6j7Zd-ZJq+djs8AoJ_dMaWmPVX2eiFoD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 16, 2010 at 2:44 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Dec 16, 2010 at 02:08:11PM +0530, Varadarajan, Charulatha wrote:
>> > + ? ? ? oh = omap_hwmod_lookup("mailbox");
>> > + ? ? ? if (!oh) {
>> > + ? ? ? ? ? ? ? pr_err("%s: unable to find hwmod\n", __func__);
>> > + ? ? ? ? ? ? ? return;
>> > + ? ? ? }
>> > +
>> > + ? ? ? od = omap_device_build("omap-mailbox", -1, oh,
>> > + ? ? ? ? ? ? ? ? ? ? ? NULL, 0,
>> > + ? ? ? ? ? ? ? ? ? ? ? mbox_latencies, ARRAY_SIZE(mbox_latencies),
>> > + ? ? ? ? ? ? ? ? ? ? ? 0);
>> > + ? ? ? if (!od) {
>>
>> Check for IS_ERR(od).
>>
>> > + ? ? ? ? ? ? ? pr_err("%s: could not build device\n", __func__);
>
> If you have an API which returns errors, and you're bothering to print
> something when an error occurs, it's often useful to print the returned
> error code, so that people can find out _why_ the error occurred.
>

Agree.

Thanks,

Omar
