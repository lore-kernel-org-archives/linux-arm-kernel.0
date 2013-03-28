From: ryan@presslab.us (Ryan Press)
Date: Wed, 27 Mar 2013 18:49:46 -0700
Subject: [PATCH v3 for 3.10] Introduce a Marvell EBU MBus driver
In-Reply-To: <CAAfodu3cfphzUPPgH7OiicnD-_YinuZZOPPStKxmOcf4uWWgpw@mail.gmail.com>
References: <1363885160-6870-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303211730.23247.arnd@arndb.de>
 <20130321184641.GB13280@titan.lakedaemon.net>
 <CAAfodu3cfphzUPPgH7OiicnD-_YinuZZOPPStKxmOcf4uWWgpw@mail.gmail.com>
Message-ID: <CABx3TkVgNEZZBKyWzz=oEbnsqk6uCST78b05H6HnNX0XWYEyWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On Wed, Mar 27, 2013 at 6:32 PM, Neil Greatorex <neil@fatboyfat.co.uk> wrote:
> Thomas,
>
> This set of patches seems to break the mvsdio driver (and hence
> mwifiex_sdio) on the Globalscale Mirabox. I believe this is because
> mvsdio.c contains a function mv_conf_mbus_windows that seems to
> conflict with the new mbus driver. I don't understand enough about the
> hardware (without the datasheets anyway) to be able to understand the
> exact problem, but I hope that this is enough to point you (or someone
> else) to it!

I've been working on getting my Mirabox running with the mainline
kernel.  There seems to be a problem with DMA and the mvsdio driver,
which causes the exact same dmesg for me.  Try loading the mvsdio
driver like so: "modprobe mvsdio nodma=1" and then modprobe the
mwifiex_sdio driver and see if it works for you too.

Ryan
