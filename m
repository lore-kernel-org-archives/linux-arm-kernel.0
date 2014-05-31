From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 31 May 2014 20:34:20 +0200
Subject: [E1000-devel] ARM support for igb driver
In-Reply-To: <CAHH3p5KdWvc_=m0XZxhb8drjpWVJ68BR_rH9bhrhNerSjCc-Tg@mail.gmail.com>
References: <CAHH3p5KAwyMOY=ai_h0eM+JwYLtTO8d4jVaVOWVtOakhqPRTew@mail.gmail.com>
 <4627439.I2CpBecnJJ@wuerfel>
 <CAHH3p5KdWvc_=m0XZxhb8drjpWVJ68BR_rH9bhrhNerSjCc-Tg@mail.gmail.com>
Message-ID: <4893591.dl3XO76euB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 31 May 2014 01:44:28 shiv prakash Agarwal wrote:
> Notsure about root port, Can't it be disabled by Intel device?

My point is that it's the wrong place to disable it: every device
is allowed to generate this type of VDMs, and the root port is
supposed to silently ignore them if it doesn't handle them.

If the root port doesn't do that, it's a bug in the host bridge
driver, not in some device driver that happens to operate a
device within the specification.

Which host bridge driver do you use?

	Arnd
