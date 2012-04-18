From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 18 Apr 2012 20:08:33 +0100
Subject: [PATCH] tty: omap-serial: Keep the wakeup mechanism enabled by
 default
In-Reply-To: <87mx69nms2.fsf@ti.com>
References: <1334579407-16970-1-git-send-email-govindraj.raja@ti.com>
 <87vckyq6ti.fsf@ti.com>
 <CAMrsUdL1S5GiyG0egS=CHg2fdNkyZVF-wuCNGDg547kfTUODng@mail.gmail.com>
 <87mx69nms2.fsf@ti.com>
Message-ID: <20120418200833.24ef25ff@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The point is that wakeups should be enabled whenever driver is in use,
> and disabled when the driver is not in use.


Which is the tty_port methods for initialisation and shutdown, which are
mutex protected against each other and hang up.

Not sure how the uart layer glue exposes that.

Alan
