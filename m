From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 Nov 2018 15:28:28 -0800
Subject: [PATCH] defconfig: arm64: add i.MX system controller thermal
 support
In-Reply-To: <1543298903-8389-1-git-send-email-Anson.Huang@nxp.com>
References: <1543298903-8389-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOesGMiDx+0BaTxoo4YPVQD-JPbX9h+drUvrKPQ6wfAyUUGjiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 26, 2018 at 10:14 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> This patch enables CONFIG_IMX_SC_THERMAL by default.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

I don't think this driver is needed to boot the system to root
filesystem, is it? If so, it would be preferred to enable this as a
module to keep kernel binary size down for all platforms.

It looks like we should revisit and bring some of the other platforms
back to modules too (Rockchip is today, but Renesas and Armada don't
seem to be).


-Olof
