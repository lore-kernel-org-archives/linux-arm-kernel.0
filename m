From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 16 Feb 2015 14:14:18 +0300
Subject: [PATCH RFC 2/2] ARM: pxa: transition to dmaengine phase 1
In-Reply-To: <1423954053-21760-3-git-send-email-robert.jarzmik@free.fr>
References: <1423954053-21760-1-git-send-email-robert.jarzmik@free.fr>
 <1423954053-21760-3-git-send-email-robert.jarzmik@free.fr>
Message-ID: <CA+E=qVfP=JY5ccUyCat5Thtk6waVng-PsnL7Y4c7_Hj+s8==nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 15, 2015 at 1:47 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> In order to slowly transition pxa to dmaengine, the legacy code will now
> rely on dmaengine to request a channel.

Hi Robert,

What about dropping old PXA DMA code completely? Daniel Mack did port
for most of PXA drivers to dma engine,
I've rebased his patches against 3.17 several months ago and fixed
oopses in pxamci and asoc drivers, but I didn't resubmit whole series
due to lack of time.

My 3.17 tree is at [1], I've tested it on pxa270 machine (Zipit Z2),
and everything works fine so far. I guess it won't be too much work to
rebase it against linux-3.20.

Regards,
Vasily

[1] https://github.com/anarsoul/linux-2.6/tree/v3.17-pxa-dmaengine-wip
