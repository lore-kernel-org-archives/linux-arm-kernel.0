From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 14 Dec 2011 13:48:31 +0200
Subject: [PATCH 3/7] remoteproc: remove unused resource type
In-Reply-To: <1323863315-8159-1-git-send-email-ohad@wizery.com>
References: <1323863315-8159-1-git-send-email-ohad@wizery.com>
Message-ID: <1323863315-8159-4-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RSC_VIRTIO_CFG isn't being used, so remove it.

Originally it was introduced to overcome a resource table limitation
that prevented describing a virtio device in a single resource table
entry.

The plan though is to describe resource table entries in a TLV fashion,
where each entry will consume the amount of space it requires,
so the original limitation is anyway temporary.

Reported-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 include/linux/remoteproc.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 1edbfde..b52f784 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -122,7 +122,6 @@ enum fw_resource_type {
 	RSC_TRACE	= 2,
 	RSC_VRING	= 3,
 	RSC_VIRTIO_DEV	= 4,
-	RSC_VIRTIO_CFG	= 5,
 };
 
 /**
-- 
1.7.5.4
