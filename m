From: khilman@ti.com (Kevin Hilman)
Date: Thu, 08 Mar 2012 13:26:12 -0800
Subject: [PATCH v3] ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
 regulators
In-Reply-To: <20120308210825.GY12083@atomide.com> (Tony Lindgren's message of
 "Thu, 8 Mar 2012 13:08:26 -0800")
References: <1330006564-13290-1-git-send-email-mporter@ti.com>
 <87wr74gis6.fsf@ti.com>
 <20120301204553.GA21841@legolas.emea.dhcp.ti.com>
 <87pqcqnc7u.fsf@ti.com>
 <CA+Bv8XaJqL1L8F-n6skY7dHn1XAdDLRKaRjw0deLeoQ5Ao0Fhg@mail.gmail.com>
 <87sjhkjj8m.fsf@ti.com> <20120308210825.GY12083@atomide.com>
Message-ID: <87y5raaiob.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@ti.com> [120307 11:05]:
>> >
>> > I don't think the second smsc911x on the Overo, "smsc911x.1", would
>> > find it due to the dev_id.
>> 
>> It's not about finding the second regulator.  As stated in the
>> changelog, it's about the duplicate attempt to register the exact same
>> platform_device.
>> 
>> Duplicate attempts to register the exact same platform_device cause
>> kobject to panic and give up[1].  So, any platform that calls
>> gpmc_smsc911x_init() twice (Overo and T35 in mainline) will panic on
>> boot.
>> 
>> This patch fixes those platforms so they can boot.
>
> Yeah but I guess the second smsc911x instance still would not work,
> or am I missing something?

I don't know since my Overo expansion boards don't have a 2nd NIC, but I
suspect you're right.

However, my fix isn't addressing that.  I am fixing a problem where
mainline today will panic on some boards due to duplicate registration.

If the 2nd interface doesn't work, then the original patch that added
the regulators needs a rethink.  My patch to prevent the panic() is
needed for mainline.

Kevin
