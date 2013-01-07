From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Jan 2013 00:14:55 +0100
Subject: machine_is_dt() ?
In-Reply-To: <50EAE2DD.805@gmail.com>
References: <20130106131805.GQ17242@lunn.ch>
 <20130106134113.GD2631@n2100.arm.linux.org.uk>
 <20130106140821.GR17242@lunn.ch> <50EAE2DD.805@gmail.com>
Message-ID: <CACRpkdZSPzfVh2fwZwB84rhpCp+5_5QWXCzSUw71MTW=D399Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 7, 2013 at 3:59 PM, Rob Herring <robherring2@gmail.com> wrote:

> You could make the platform code create the platform device in the DT
> case as well. Not all platform devices have to come from a DT node and
> putting virtual devices in DT is wrong.

For the ux500 cpufreq we do exactly this.

When the PRCMU probes in drivers/mfd/db8500-prcmu.c it spawns
a db8500-cpufreq MFD child, and the db8500-cpufreq driver then
probes as a platform device.

Yours,
Linus Walleij
