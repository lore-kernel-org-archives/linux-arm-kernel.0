From: timur@tabi.org (Timur Tabi)
Date: Thu, 03 Sep 2015 13:09:40 -0500
Subject: [PATCH v5 05/11] drivers: PL011: refactor pl011_probe()
In-Reply-To: <55E87B3E.8070106@arm.com>
References: <1432225584-4655-1-git-send-email-andre.przywara@arm.com>
 <1432225584-4655-6-git-send-email-andre.przywara@arm.com>
 <CAOZdJXVgRQZhEfYY9YdpiQ=n1D56yYL84s42V4hd2=YX2k48ZA@mail.gmail.com>
 <55E87B3E.8070106@arm.com>
Message-ID: <55E88CE4.7080401@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/2015 11:54 AM, Andre Przywara wrote:

> I don't get where pl011_early_write() would need any kind of PL011 struct.
> It only references structures defined in the serial core, so it's
> completely dumb MMIO writes and reads, using only the base address
> provided on the command line.
> Are you by any chance mixing up early console and the normal console? To
> me it looks like early console just uses the three tiny functions
> defined just before the declaration and it does not touch vendor at all,
> isn't it?
>
> As for the broken part, any chance you were testing -next, which has
> some patches that broke early console, as we learned today?[1]

I have to apologize -- I forgot that I applied an internal patch that 
modified this code, and the bug is in that patch, not yours.  Your code 
is fine as is.
