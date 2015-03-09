From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Mar 2015 15:29:09 +0100
Subject: [PATCH 1/5] MFD/OF: document MFD devices and handle simple-mfd
In-Reply-To: <20150303102550.GA32624@x1>
References: <1425375148-4369-1-git-send-email-linus.walleij@linaro.org>
 <1425375148-4369-2-git-send-email-linus.walleij@linaro.org>
 <20150303102550.GA32624@x1>
Message-ID: <CACRpkdaFz35PAnUv50J4hA8LA9WUUB97_Qmbb-3iAMjuaB4iUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 3, 2015 at 11:25 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 03 Mar 2015, Linus Walleij wrote:

>> +Multi-Function Devices (MFD)
>> +
>> +These devices comprise a nexus for heterogeneous hardware blocks
>
> I don't think you meant 'comprise' here.  Perhaps 'represent' might
> fit better?

I meant "comprise", even looked up the same word in a Swedish-English
dictionary. I mean those devices really are such heterogeneous things,
not just modeled like such in Linux.

>> +spawning multiple child devices.
>
> Spawning devices is something software will do.  Think less about what
> the actions the OS will take order to handle these IPs and more about
> what they are physically.  I would prefer the description mentions
> that these chips are single pieces of silicon which contain >1 devices
> with non-unique/varying functionality.

OK.

>> +A typical MFD can be:
>> +
>> +- A mixed signal ASIC on an external bus, sometimes a PMIC (power management
>> +  integrated circuit) that is manufactured in a lower technology node (rough
>
> Please capitalise the expanded PMIC abbreviation.

OK.

>> +  silicon) that handles analog drivers for things like audio amplifiers, LED
>> +  drivers, level shifters, PHY (physical interfaces to things like USB or
>> +  ethernet), regulators etc.
>> +
>> +- A range of memory registers containing "miscellaneous system registers" also
>> +  known as a system controller "syscon" or any other memory range containing a
>> +  mix of unrelated registers.
>
> s/registers/{hardware|devices}/

OK.

>> +Optional properties:
>> +
>> +- compatible : "simple-mfd" - this signifies that the operating system should
>> +  spawn child devices for all the subnodes of the MFD device akin to how
>
> This is pretty Linux specific IMHO.  Other OSes might not spawn
> seperate devices to handle MFD type h/w.  The idea is fine, but please
> generify a little.

OK.

>> +foo at 1000 {
>
> Should be 10000.

OK.

>> +             compatible = "syscon", "simple-mfd";
>
> Please address your tabbing issues.

OK.

Yours,
Linus Walleij
