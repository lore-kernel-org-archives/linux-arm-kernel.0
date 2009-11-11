From: chripell@gmail.com (christian pellegrin)
Date: Wed, 11 Nov 2009 14:39:32 +0100
Subject: atmel_serial losing characters under libmodbus
In-Reply-To: <4AFAB1BE.4040008@gmail.com>
References: <4AFAB1BE.4040008@gmail.com>
Message-ID: <cabda6420911110539h4c0e976aja4478212886d3c22@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2009 at 1:44 PM, Josef Holzmayr
<zentrale.at.work@gmail.com> wrote:
> When using libmodbus on an atmel_serial line, it seems to lose about 1 char
> in 50 that it's supposed to receive. This is independet of the baud rate, it
> happens everywhere from 2400 to 19200. Full code excerpt from the lib is
> below, but basically reading is just an select/read pair. Are there some
> known issues with that particular tty device?
>

Hi, the only serial port on AT91 that gives me troubles is the DBGU
port which shares the interrupt with the timer tick. You see a lot of
serial overruns there if you have the kernel compiled with HZ=1000 on
that port (usually ttyS0).



-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
