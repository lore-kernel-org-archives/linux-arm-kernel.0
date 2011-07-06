From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 13:58:48 +0200
Subject: [PATCH V2 6/6] mpcore_wdt: Move declarations in a separate header
In-Reply-To: <1309892440-3260-7-git-send-email-vkuzmichev@mvista.com>
References: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
	<1309892440-3260-7-git-send-email-vkuzmichev@mvista.com>
Message-ID: <201107061358.48496.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 July 2011, Vitaly Kuzmichev wrote:
> Signed-off-by: Vitaly Kuzmichev <vkuzmichev@mvista.com>
> ---
>  drivers/watchdog/mpcore_wdt.c |   26 +-------------------------
>  drivers/watchdog/mpcore_wdt.h |   40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 25 deletions(-)
>  create mode 100644 drivers/watchdog/mpcore_wdt.h

I don't see the point in this. IMHO it's better to leave the definitions
in the same file that uses them, because they are not shared across
multiple files.

If you intend to share them in the future, you should explain that
in the changelog.

	Arnd
