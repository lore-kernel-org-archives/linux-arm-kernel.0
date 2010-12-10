From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 10 Dec 2010 08:56:28 -0800
Subject: [PATCH v7 11/12] davinci: add tnetv107x evm backlight device
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930247CD8CE8@dbde02.ent.ti.com>
	(Sekhar Nori's message of "Fri, 10 Dec 2010 21:31:59 +0530")
References: <1291733522-3626-1-git-send-email-cyril@ti.com>
	<1291733522-3626-12-git-send-email-cyril@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247CD83E1@dbde02.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247CD84F4@dbde02.ent.ti.com>
	<4D00EEA1.8070201@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247CD8CE8@dbde02.ent.ti.com>
Message-ID: <87aakdd0sj.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Nori, Sekhar" <nsekhar@ti.com> writes:

> On Thu, Dec 09, 2010 at 20:28:41, Chemparathy, Cyril wrote:
>> On 12/09/2010 06:00 AM, Nori, Sekhar wrote:
>> > On Thu, Dec 09, 2010 at 14:25:49, Nori, Sekhar wrote:
>> >
>> >> This call should simply return if machine is not tnetv107x EVM.
>> >>
>> >> I didn't follow the entire series but wondering why
>> >> platform device registration should be a late init call.
>> >> Typically the driver probe can be made a late init call
>> >> in case of init sequence dependencies.
>> >
>> > I meant driver init, not probe.
>>
>> This was done to handle driver dependencies, and is meant to be
>> temporary (until a real driver dependency framework comes in).
>>
>> Please see [1] for a bit more of background on changing drivers to use
>> module_init().
>
> Hmm, okay. Please include a check for machine in that case.
>

Sekhar is right.  

Today, we don't (can't) build this machine with others for a couple
reasons, but we're moving towards removing those restrictions, so when
this machine is included in a binary with others, it needs to check.

Thanks,

Kevin
