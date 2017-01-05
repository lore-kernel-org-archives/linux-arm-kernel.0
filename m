From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 05 Jan 2017 13:55:17 +0100
Subject: [PATCH 3/8] ARM: dts: armada-388-clearfog: Utilize new DSA binding
In-Reply-To: <5a40436a-ebad-8a94-c5c5-546ba33ba545@gmail.com> (Florian
 Fainelli's message of "Wed, 4 Jan 2017 09:27:35 -0800")
References: <20170102022249.10657-1-f.fainelli@gmail.com>
 <20170102022249.10657-4-f.fainelli@gmail.com>
 <87shoyeo2j.fsf@free-electrons.com>
 <5a40436a-ebad-8a94-c5c5-546ba33ba545@gmail.com>
Message-ID: <87k2a9d5u2.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,
 
 On mer., janv. 04 2017, Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 01/04/2017 09:23 AM, Gregory CLEMENT wrote:
>> Hi Florian,
>>  
>>  On lun., janv. 02 2017, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> 
>>> Utilize the new DSA binding, introduced with commit 8c5ad1d6179d ("net:
>>> dsa: Document new binding"). The legacy binding node is kept included, but is
>>> marked disabled.
>>>
>> 
>> I tested this patch on mvebu/dt (I needed to reduce the context to apply
>> the patch due to the changes made by Russell King on this file). I also
>> set the status of the old binding to "disable" (instead of "okay").
>
> Yes, that needs fixing, thanks for mentioning that.
>
>> 
>> It seems to work with the limited test did:
>> ifconfig eth1 up
>> udhcpc -i lan1
>> iperf -c mylaptop
>> 
>> (same for lan4)
>> 
>> However is there a way to be sure that the new binding is used?
>
> The best way is probably to make sure that your switch device appears
> parented to the MDIO bus driver under /sys/class/mdio_bus/*mvmdio*.
> Alternatively, if you see a message like:
>
> DSA: switch 0 0 parsed
>
> in your dmesg, that would also be indicative of using the new binding
> and corresponding code.

So it's OK I had this message.

Gregory


>
> Thanks a lot for trying that out!
> -- 
> Florian

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
