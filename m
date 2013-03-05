From: hechtb@gmail.com (Bastian Hecht)
Date: Tue, 5 Mar 2013 14:47:17 +0100
Subject: [PATCH v4 3/3] ARM: mach-shmobile: r8a7740: Setup the serial
 devices using DT
In-Reply-To: <5135F647.8050002@cogentembedded.com>
References: <1362414054-23092-1-git-send-email-hechtb+renesas@gmail.com>
 <1362414054-23092-3-git-send-email-hechtb+renesas@gmail.com>
 <2835497.S76YK1KMLM@wuerfel>
 <CABYn4sx=bC6JwicbVgRnmwdu=6DuW5GFgdG25a-Wow1Jn9M-bQ@mail.gmail.com>
 <5135F647.8050002@cogentembedded.com>
Message-ID: <CABYn4swottJ6knJXfHntJuWJ9rzrC7kA-47TaKJRG0mh+u+Pig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/5 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>:
> Hello.
>
>
> On 05-03-2013 17:00, Bastian Hecht wrote:
>
>>>> +       sci at e6c40000 {
>>>> +               compatible = "renesas,sci-SCIFA-uart";
>>>> +               interrupt-parent = <&intca>;
>>>> +               reg = <0xe6c40000 0x100>;
>>>> +               interrupts = <0x0c00>, <0x0c00>, <0x0c00>, <0x0c00>;
>>>> +               cell-index = <0>;
>>>> +               renesas,scscr = <0x30>;
>>>> +               renesas,scbrr-algo-id = <4>;
>>>> +               renesas,autoconf;
>>>> +       };
>>>
>>>
>>> The default name for a uart is "serial", I would recommend sticking to
>>> that by convention. You may also want to add an "aliases" node
>>> somewhere, to define which port should get which logical device number
>>> on a given board.
>
>
>> Switched to "...-serial".
>
>
>    I think he was talking about the node name, not "compatible" property.

Ah sure! I'll wait for responses to v5 and will change it around in v6.

Thanks,

 Bastian


> WBR, Sergei
>
