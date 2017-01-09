From: bvantiel@gmail.com (Bas van Tiel)
Date: Mon, 9 Jan 2017 19:06:19 +0100
Subject: Unhandled level 2 translation fault (11) at 0x000000b8, esr
 0x92000046, rpi3 (aarch64)
In-Reply-To: <20170109151354.GC7593@e104818-lin.cambridge.arm.com>
References: <CAGDbNAD7-TM6+x0A3FebTOPYmqQqbm1w29ZwH+9qePaAvhxTKw@mail.gmail.com>
 <20161230151323.583b7ac5@xhacker>
 <CAGDbNAAGqFqt7X+=XYRLAp=L_fTv9dAAe=wu4T_W-FCGqnYHHg@mail.gmail.com>
 <20170109151354.GC7593@e104818-lin.cambridge.arm.com>
Message-ID: <CAGDbNAC-8w1xytLuzWTMnWLi8=j1ShkwE3CLXQ5q75m_RibCMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I defined STACKSIZE to the kernel's SIGSTKSZ (16384) and it seems to run
> fine, though I'll leave it longer/overnight (on a Juno board). With the
> 4K signal stack it was crashing shortly after start.

I tried the STACKSIZE of 16384 for both the RPI3 and the PINEA64 board
and still see the same behaviour of crashing. Sometimes the process
is also blocked for a long time before it crashes.

Setting the interval to 200 usec [5 Khz] will help to crash it faster.

To further isolate the issue I will create a kernel module (based on a
hrtimer) that will sent a periodic signal to the registered process
and execute the same sighandler logic to check if the problem is still
there.

regards
Bas
