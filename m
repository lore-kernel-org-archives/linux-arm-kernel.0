From: jp.francois@cynove.com (jean-philippe francois)
Date: Mon, 13 May 2013 11:28:38 +0200
Subject: [PATCH] ARM: OMAP: fix __init section mismatch for _enable_preprogram
Message-ID: <CAGGh5h1_-zbe=gw+YtMeddGxGkVzos=siavOv9nbSOVZqk1nVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

_enable_preprogram is marked as __init, but is called from _enable
which is not. Without this patch, the board oopses after init. Tested
on custom hardware and on beagle board xM.

Signed-off-by: Jean-Philippe Fran?ois <jp.francois@cynove.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: omap_hwmod_fix.patch
Type: application/octet-stream
Size: 494 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130513/e9423fe7/attachment.obj>
