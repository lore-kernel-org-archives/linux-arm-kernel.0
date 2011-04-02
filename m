From: Hong-Xing.Zhu@freescale.com (Richard Zhu)
Date: Sat, 2 Apr 2011 15:04:39 +0800
Subject: [PATCH RFC 0/1] RAMDISK: doing write barrier will return -EIO
Message-ID: <1301727880-2456-1-git-send-email-Hong-Xing.Zhu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 drivers/block/brd.c |    6 ++++--
  1 files changed, 4 insertions(+), 2 deletions(-)

  One RAMDISK issue when use the RAMDISK as the removable device through
  USB OTG on MX51 BBG board.
  
  Here are the reproduce steps:
  1. enable ramdisk in kernel and make default size to 16M.
  2. connect board to PC through USB otg port.
  3. modprobe g_file_storage file=/dev/ram0 removable=1.
  4. check the removable usb devices on PC and need to be formatted
   then write a file to this disk. found data error when create a new
   file on disk in window explore

In-Reply-To: 
