From: oneukum@suse.de (Oliver Neukum)
Date: Wed, 10 Oct 2012 14:35:36 +0200
Subject: [PATCH v2] USB: usb-skeleton.c: fix compilation error and restore
 kref_put on fail in skel_open
In-Reply-To: <1349865174-21649-1-git-send-email-const@MakeLinux.com>
References: <1349865174-21649-1-git-send-email-const@MakeLinux.com>
Message-ID: <1952553.sIPjpLauNn@linux-lqwf.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 October 2012 12:32:54 Constantine Shulyupin wrote:
> From: Constantine Shulyupin <const@MakeLinux.com>
> 
> Function skel_open increments usage count for the device with kref_get and the usage count should be decremented on the function failure.
> 
> Some last changes in function skel_open and finally commit
> 52a7499 Revert "USB: usb-skeleton.c: fix open/disconnect race"
> introduced a bug in function skel_open, which this patch fixes.
> 
> --
> Changelog:
> -- Fixed accordinly feedback of Oliver Neukum oneukum at suse.de: also need to drop the lock.

Well, touching file->private_data is not nice. It is correct, but
really dirty. The skeleton driver should be nice. Could you introduce
a second label for goto at the right place?

	Regards
		Oliver
