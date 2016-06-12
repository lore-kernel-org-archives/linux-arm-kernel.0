From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 12 Jun 2016 11:36:59 -0300
Subject: [PATCH 1/2] ARM: dts: imx6q-cm-fx6: fix the operation points
In-Reply-To: <2256c64f85d847d29c2c3e0f4e095d90@rwthex-s1-b.rwth-ad.de>
References: <6b48c849983548f29259b42d69c5224c@rwthex-s1-b.rwth-ad.de>
 <650a7982db35484194a0be26863a89f9@rwthex-s1-a.rwth-ad.de>
 <2256c64f85d847d29c2c3e0f4e095d90@rwthex-s1-b.rwth-ad.de>
Message-ID: <CAOMZO5APbW8Hc_HCEyF=22T320KJ6K+E1AVpZPH4Rkzjqi-8rQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2016 at 11:05 AM, Christopher Spinrath
<christopher.spinrath@rwth-aachen.de> wrote:

> Well, without this patch the SoC runs at 1.2GHz so it seems like the
> fuse indicates that it is possible. But with a fair amount of IPs
> enabled and high load the board becomes unstable (display
> flickering/blanks, ethernet package drops, ...). I guess CompuLab
> allowed 1.2GHz at first and then realized that it is a bad idea (at
> least for some boards).
>
> Is there any way to influence the fuse (e.g. from the
> firmware/bootloader) or do you have another proposal on how to fix this
> issue?

Ok, understood. So the mx6q fuse indicates that 1.2GHz operation is
possible on , but the board itself does not behave nicely at this
frequency.

Maybe you could send a v2 of this patch that matches the operating
points form mx6qdl.dtsi and remove only the 1.2GHz entry and put the
explanation you gave us here in the dts and commit log.

Regards,

Fabio Estevam
