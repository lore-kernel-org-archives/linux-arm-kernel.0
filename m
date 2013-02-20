From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 20 Feb 2013 06:30:00 -0800
Subject: [RFC v2 16/18] ARM: OMAP2+: AM33XX: Basic suspend resume support
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED2C85F@DBDE01.ent.ti.com>
 (Vaibhav Bedia's message of "Wed, 20 Feb 2013 09:21:41 +0000")
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-17-git-send-email-vaibhav.bedia@ti.com>
 <87k3qewcbt.fsf@linaro.org>
 <B5906170F1614E41A8A28DE3B8D121433ED1D197@DBDE01.ent.ti.com>
 <87lialzjne.fsf@linaro.org>
 <B5906170F1614E41A8A28DE3B8D121433ED2C85F@DBDE01.ent.ti.com>
Message-ID: <87zjyzqcrb.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Bedia, Vaibhav" <vaibhav.bedia@ti.com> writes:

[...]

>> IMO, this would be a much cleaner implementation if you just created a
>> small driver for the wkup_m3.  You're already doing a bunch of
>> driver-like stuff for it (requesting base/IRQs, mapping regions,
>> firmware, etc.)  I think this should separated out into a real driver.
>> Then it will be bound to the right omap_device, and normal PM operations
>> will work as expected.
>> 
>> Also, doing it this way will be more flexible for those wanting to use
>> their own firmware on the M3, or customize the current firmware.
>
> Hmm... that definitely sounds more flexible. It should also help in the next SoC
> AM437x which has a similar PM architecture. Where would you suggest placing
> this minimal driver?

For now, just leave it in mach-omap2 and we can figure out the right
home for it eventually.

Kevin
