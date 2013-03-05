From: hechtb@gmail.com (Bastian Hecht)
Date: Tue, 5 Mar 2013 14:00:41 +0100
Subject: [PATCH v4 3/3] ARM: mach-shmobile: r8a7740: Setup the serial
 devices using DT
In-Reply-To: <2835497.S76YK1KMLM@wuerfel>
References: <1362414054-23092-1-git-send-email-hechtb+renesas@gmail.com>
 <1362414054-23092-3-git-send-email-hechtb+renesas@gmail.com>
 <2835497.S76YK1KMLM@wuerfel>
Message-ID: <CABYn4sx=bC6JwicbVgRnmwdu=6DuW5GFgdG25a-Wow1Jn9M-bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2013/3/4 Arnd Bergmann <arnd@arndb.de>:
> On Monday 04 March 2013 17:20:54 Bastian Hecht wrote:
>>
>> +       sci at e6c40000 {
>> +               compatible = "renesas,sci-SCIFA-uart";
>> +               interrupt-parent = <&intca>;
>> +               reg = <0xe6c40000 0x100>;
>> +               interrupts = <0x0c00>, <0x0c00>, <0x0c00>, <0x0c00>;
>> +               cell-index = <0>;
>> +               renesas,scscr = <0x30>;
>> +               renesas,scbrr-algo-id = <4>;
>> +               renesas,autoconf;
>> +       };
>
> The default name for a uart is "serial", I would recommend sticking to
> that by convention. You may also want to add an "aliases" node
> somewhere, to define which port should get which logical device number
> on a given board.

Switched to "...-serial".
About the aliases: Would I need to add that now, or can we postpone that?

Thanks,

 Bastian


>         Arnd
