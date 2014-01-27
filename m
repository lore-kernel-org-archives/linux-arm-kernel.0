From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 27 Jan 2014 09:25:01 +0100
Subject: GPIO triggers kernel reboot
In-Reply-To: <8761p5hmni.fsf@lebrac.rtp-net.org>
References: <52E3E031.6040709@denx.de>
 <CALLGbRKK_ZcOB6nAiV67njrphXMQXN7Y2s81n5k3PWoSVrsrUw@mail.gmail.com>
 <52E5FB1A.2020205@denx.de> <8761p5hmni.fsf@lebrac.rtp-net.org>
Message-ID: <CAMuHMdX-sRhwddcvrS8KSO9hTMc94PyAhaBTef7rckwvnL-OiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 9:08 AM, Arnaud Patard
<arnaud.patard@rtp-net.org> wrote:
>>> It's certainly possible, and it's also easily done from user-space.
>>>   Something like this is more policy than function.  It's also a potential
>>> security issue.  As such I'd expect it highly unlikely that the kernel
>>> maintainers would allow it to go upstream. Give it a try though.
>>
>> Ok, thats what I also think ...
>>
>>> I'd approach this from user-space.  Add in the gpio-keys driver and use the
>>> input-event-daemon to trigger a reboot.  Super easy.
>>
>> Yes, that was also my suggestion, but is there a way to do this without
>> user space usage in a generic way?
>
> I think that you can register an input handler for that. iirc, there was
> a driver doing something similar for apm.

According to Documentation/sysctl/kernel.txt, the default for the
"ctrl-alt-del" input is to just reboot.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
