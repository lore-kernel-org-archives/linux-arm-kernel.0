From: chhotu.shiv@gmail.com (shiv prakash Agarwal)
Date: Sun, 1 Jun 2014 11:26:57 +0530
Subject: [E1000-devel] ARM support for igb driver
In-Reply-To: <4893591.dl3XO76euB@wuerfel>
References: <CAHH3p5KAwyMOY=ai_h0eM+JwYLtTO8d4jVaVOWVtOakhqPRTew@mail.gmail.com>
 <4627439.I2CpBecnJJ@wuerfel>
 <CAHH3p5KdWvc_=m0XZxhb8drjpWVJ68BR_rH9bhrhNerSjCc-Tg@mail.gmail.com>
 <4893591.dl3XO76euB@wuerfel>
Message-ID: <CAHH3p5JDXVZAKQUUQ5ao1GzwhNtU-+Hs_afT0tYeaw9oUthu-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I don't see all devices send VDMs, then why Intel I-210?
Also, Is it a bug in host bridge hardware or driver? If hardware, how
can we make device not to send it?

On Sun, Jun 1, 2014 at 12:04 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 31 May 2014 01:44:28 shiv prakash Agarwal wrote:
>> Notsure about root port, Can't it be disabled by Intel device?
>
> My point is that it's the wrong place to disable it: every device
> is allowed to generate this type of VDMs, and the root port is
> supposed to silently ignore them if it doesn't handle them.
>
> If the root port doesn't do that, it's a bug in the host bridge
> driver, not in some device driver that happens to operate a
> device within the specification.
>
> Which host bridge driver do you use?
>
>         Arnd
