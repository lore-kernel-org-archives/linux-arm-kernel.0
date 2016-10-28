From: vincent.stehle@laposte.net (Vincent =?iso-8859-1?Q?Stehl=E9?=)
Date: Fri, 28 Oct 2016 09:52:54 +0200
Subject: [PATCH next 1/2] media: mtk-mdp: fix video_device_release argument
In-Reply-To: <20161027202325.20680-1-vincent.stehle@laposte.net>
References: <1473340146-6598-4-git-send-email-minghsiu.tsai@mediatek.com>
 <20161027202325.20680-1-vincent.stehle@laposte.net>
Message-ID: <20161028075253.gdy2bbugih6oqncw@romuald.bergerie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 10:23:24PM +0200, Vincent Stehl? wrote:
> video_device_release() takes a pointer to struct video_device as argument.
> Fix two call sites where the address of the pointer is passed instead.

Sorry, I messed up: please ignore that "fix". The 0day robot made me
realize this is indeed not a proper fix.

The issue remains, though: we cannot call video_device_release() on the
vdev structure member, as this will in turn call kfree(). Most probably,
vdev needs to be dynamically allocated, or the call to
video_device_release() dropped completely.

Sorry for the bad patch.

Best regards,

Vincent.
