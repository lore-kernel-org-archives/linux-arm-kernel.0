From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 19 Feb 2016 09:45:18 +0000
Subject: [PATCH v3 05/10] serial: mps2-uart: add support for early console
In-Reply-To: <56C31F9F.10000@arm.com>
References: <1455617295-23736-1-git-send-email-vladimir.murzin@arm.com>	<1455617295-23736-6-git-send-email-vladimir.murzin@arm.com>
 <CAHp75VdugAq0WnzLHmd9CJHCjBOdBwPqCmC3ARSaVF5XMYGoMw@mail.gmail.com>
 <56C31F9F.10000@arm.com>
Message-ID: <56C6E42E.5070601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/02/16 13:09, Vladimir Murzin wrote:
>>> +EARLYCON_DECLARE(mps2, mps2_early_console_setup);
>>> >> +OF_EARLYCON_DECLARE(mps2, "arm,mps2-uart", mps2_early_console_setup);
>> > 
>> > IIRC Peter Hurley mentioned you don't need to put both anymore, OF_
>> > one is enough.
>> > 
> I've just tried with OF_ only and seems it works fine. Thanks for
> pointing at it!
> 

..and the reason for that was that I had stdout pointing at uart node.
Now, while testing v4 I end-up with configuration:

1) no EARLYCON_DECLARE in mps2-uart.c
2) stdout not set
3) cmdline has "earlycon=mps2,0x40004000 console=/dev/ttyMPS"

and I don't see bootconsole, but if I avoid 1) everything works fine.
So, I'd leave EARLYCON_DECLARE in this patch.

Cheers
Vladimir
