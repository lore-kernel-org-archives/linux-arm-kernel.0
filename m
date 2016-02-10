From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Wed, 10 Feb 2016 13:49:14 +0000
Subject: [PATCH 1/8] arm64: KVM: Switch the sys_reg search to be a binary
 search
In-Reply-To: <1454931622-14902-2-git-send-email-marc.zyngier@arm.com>
References: <1454931622-14902-1-git-send-email-marc.zyngier@arm.com>
 <1454931622-14902-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <87ziv8vfol.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Marc Zyngier <marc.zyngier@arm.com> writes:

> Our 64bit sys_reg table is about 90 entries long (so far, and the
> PMU support is likely to increase this). This means that on average,
> it takes 45 comparaisons to find the right entry (and actually the
> full 90 if we have to search the invariant table).
>
> Not the most efficient thing. Specially when you think that this
> table is already sorted. Switching to a binary search effectively
> reduces the search to about 7 comparaisons. Slightly better!

Is there an argument for making this a hash table instead or is this not
possible as you would have to use dynamically allocated instead?

--
Alex Benn?e
