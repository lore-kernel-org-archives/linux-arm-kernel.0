From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 22 Apr 2014 17:42:34 -0700
Subject: [PATCH] Input: atkbd - fix keyboard LG Electronics
In-Reply-To: <1398185970-16331-1-git-send-email-ssl@chromium.org>
References: <1398185970-16331-1-git-send-email-ssl@chromium.org>
Message-ID: <20140423004233.GC22547@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sheng-Liang,

On Tue, Apr 22, 2014 at 09:59:30AM -0700, Sheng-Liang Song wrote:
> After issuing ATKBD_CMD_RESET_DIS, LG Keyboard stop working.
> The workaround is to issue ATKBD_CMD_RESET_DEF after ATKBD_CMD_RESET_DIS.

Hmm, if ATKBD_CMD_RESET_DIS causes keyboard not working should we
simply not call it on LG devices?

The idea for using ATKBD_CMD_RESET_DIS was for keyboard to stop
generating scan codes so they do not interfere with detection/resume and
issuing ATKBD_CMD_RESET_DEF right after ATKBD_CMD_RESET_DIS keeps
keyboard in exactly the same state as it was before (i.e. generating
scancodes).

Thanks.

-- 
Dmitry
