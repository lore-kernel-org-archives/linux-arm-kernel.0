From: fkan@apm.com (Feng Kan)
Date: Tue, 14 Jan 2014 10:35:33 -0800
Subject: [PATCH V2 1/6] Documentation: add dts binding for X-Gene reboot
 dts node.
In-Reply-To: <201401140706.13406.arnd@arndb.de>
References: <1389135041-16062-1-git-send-email-fkan@apm.com>
 <201401132043.52491.arnd@arndb.de>
 <CAL85gmCA4kBsRUMC_ENjGfCq5jM11iY5Jx_+A3V9XQDU0b7E0A@mail.gmail.com>
 <201401140706.13406.arnd@arndb.de>
Message-ID: <CAL85gmD+34VKSHsGXWTbQ2w3razo_cKukfe=dSQJi+x-Zfvtpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 10:06 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 14 January 2014, Feng Kan wrote:
>>
>> >
>> > Is this related to the standard ARM SCU that manages multiprocessor
>> > systems, or a different unit that uses the same name?
>>
>> FKAN: You mean the snoop control unit in ARM. This is different from
>> that, the main function of this unit is clk control.
>
> Hmm, if it's *mainly* used for clocks, you may actually just want to
> have a driver in drivers/clk for it that also performs a few of the
> other things on the side.
>

FKAN: there among other thing, reset controls, fuse id's and deep sleep
resume registers... I like your idea of using syscon, we can have a node
for SCU and then the specific driver to parse out the needed chunk to use.

>         Arnd
