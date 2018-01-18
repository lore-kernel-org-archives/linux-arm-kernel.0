From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 18 Jan 2018 22:27:21 +0100
Subject: [patch v15 4/4] Documentation: jtag: Add ABI documentation
In-Reply-To: <1514202808-29747-5-git-send-email-oleksandrs@mellanox.com>
References: <1514202808-29747-1-git-send-email-oleksandrs@mellanox.com>
 <1514202808-29747-5-git-send-email-oleksandrs@mellanox.com>
Message-ID: <20180118212720.GA17196@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2017-12-25 13:53:28, Oleksandr Shamray wrote:
> Added document that describe the ABI for JTAG class drivrer
> 
> Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v14->v15
> v13->v14
> v12->v13
> v11->v12
> Tobias Klauser <tklauser@distanz.ch>
> - rename /Documentation/ABI/testing/jatg-dev -> jtag-dev
> - Typo: s/interfase/interface
> v10->v11
> v9->v10
> Fixes added by Oleksandr:
> - change jtag-cdev to jtag-dev in documentation
> - update Kernel Version and Date in jtag-dev documentation;
> v8->v9
> v7->v8
> v6->v7
> Comments pointed by Pavel Machek <pavel@ucw.cz>
> - Added jtag-cdev documentation to Documentation/ABI/testing folder
> ---
>  Documentation/ABI/testing/jtag-dev |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/ABI/testing/jtag-dev
> 
> diff --git a/Documentation/ABI/testing/jtag-dev b/Documentation/ABI/testing/jtag-dev
> new file mode 100644
> index 0000000..cab867d
> --- /dev/null
> +++ b/Documentation/ABI/testing/jtag-dev
> @@ -0,0 +1,27 @@
> +What:		/dev/jtag[0-9]+
> +Date:		October 2017
> +KernelVersion:	4.15
> +Contact:	oleksandrs at mellanox.com
> +Description:
> +		The misc device files /dev/jtag* are the interface
> +		between JTAG master interface and userspace.
> +
> +		The ioctl(2)-based ABI is defined and documented in
> +		[include/uapi]<linux/jtag.h>.
> +
> +		The following file operations are supported:
> +
> +		open(2)
> +		The argument flag currently support only one access
> +		mode O_RDWR.
> +
> +		ioctl(2)
> +		Initiate various actions.
> +		See the inline documentation in [include/uapi]<linux/jtag.h>
> +		for descriptions of all ioctls.

Sorry, can we have real docs? I tried to decipher it from jtag.h, but
its not easy. We should have API docs...


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180118/e4452250/attachment-0001.sig>
