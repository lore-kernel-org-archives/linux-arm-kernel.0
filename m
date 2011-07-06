From: vkuzmichev@mvista.com (Vitaly Kuzmichev)
Date: Wed, 06 Jul 2011 16:36:41 +0400
Subject: [PATCH V2 6/6] mpcore_wdt: Move declarations in a separate header
In-Reply-To: <201107061358.48496.arnd@arndb.de>
References: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
	<1309892440-3260-7-git-send-email-vkuzmichev@mvista.com>
	<201107061358.48496.arnd@arndb.de>
Message-ID: <4E1456D9.8090003@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 07/06/2011 03:58 PM, Arnd Bergmann wrote:
> On Tuesday 05 July 2011, Vitaly Kuzmichev wrote:
>> Signed-off-by: Vitaly Kuzmichev <vkuzmichev@mvista.com>
>> ---
>>  drivers/watchdog/mpcore_wdt.c |   26 +-------------------------
>>  drivers/watchdog/mpcore_wdt.h |   40 ++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 41 insertions(+), 25 deletions(-)
>>  create mode 100644 drivers/watchdog/mpcore_wdt.h
> 
> I don't see the point in this. IMHO it's better to leave the definitions
> in the same file that uses them, because they are not shared across
> multiple files.
> 
> If you intend to share them in the future, you should explain that
> in the changelog.

The patch is aimed to resolve checkpatch warning on "extern" function
prototype:

WARNING: externs should be avoided in .c files
#44: FILE: drivers/watchdog/mpcore_wdt.c:37:
+unsigned long twd_timer_get_rate(void);

If it's ok to leave this warning I would also like to throw out this patch.

Thanks,
Vitaly.
