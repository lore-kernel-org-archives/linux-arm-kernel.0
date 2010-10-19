From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 19 Oct 2010 17:12:43 -0600
Subject: [PATCH 3/3] omap: add hwspinlock device
In-Reply-To: <AANLkTinZ2+ocJCfUpT15Ow3J9XBa-8XWnVC3gDDJ7s-v@mail.gmail.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<1287387875-14168-4-git-send-email-ohad@wizery.com>
	<87r5fmxghm.fsf@deeprootsystems.com>
	<AANLkTinZ2+ocJCfUpT15Ow3J9XBa-8XWnVC3gDDJ7s-v@mail.gmail.com>
Message-ID: <AANLkTimTDCbLP+EeUeo35re0FrMvqV3ozU+v7DZXr_p3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 19, 2010 at 3:02 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Tue, Oct 19, 2010 at 7:03 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>>> +postcore_initcall(hwspinlocks_init);
>>
>> Any reason this needs to be a postcore_initcall? ?Are there users of
>> hwspinlocks this early in boot?
>
> i2c-omap, which is subsys_initcall (the I2C bus is shared between the
> A9 and the M3 on some OMAP4 boards).
>
> And to allow early board code to reserve specific hwspinlock numbers
> for predefined use-cases, we probably want to be before arch_initcall.

Man. this is getting ugly.  I think we need to discuss how to solve
this at the Plumbers micro-conference. It kind of fits in with the
whole embedded (ab)use of the device model topic anyway. Actually,
this particular case isn't bad, but the moving of i2c and spi busses
to an earlier initcall is just band-aiding the real problem of driver
probe order dependencies.

g.
