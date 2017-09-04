From: lukas@wunner.de (Lukas Wunner)
Date: Mon, 4 Sep 2017 07:46:37 +0200
Subject: [PATCH v3 0/8] PM / ACPI / i2c: Deploy runtime PM centric path
 for system sleep
In-Reply-To: <1668277.7DWLdgHGid@aspire.rjw.lan>
References: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org>
 <3033151.kbPpEQGlRq@aspire.rjw.lan>
 <CAPDyKFqAqiDcdwEOwEu1m7icnP8MijYf4UNrMqN9YhNbug_upg@mail.gmail.com>
 <1668277.7DWLdgHGid@aspire.rjw.lan>
Message-ID: <20170904054637.GA23707@wunner.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 04, 2017 at 02:17:21AM +0200, Rafael J. Wysocki wrote:
> OTOH I'm starting to think that direct_complete is only theoretically
> useful and may not be actually set very often in practice, whereas it
> adds significant complexity to the code, so I'm not sure about it any
> more.

That makes me come out of the woodwork as a direct_complete fan:

Runtime resuming a discrete GPU on a modern dual GPU laptop takes about
1.5 sec, runtime resuming Thunderbolt controllers more than 2 sec.
A discrete GPU easily consumes 10W, a Thunderbolt controller 2W.

So not having direct_complete would noticeably delay system suspend and
resume as well as reduce battery life.

Lukas
