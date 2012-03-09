From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Mar 2012 12:41:19 +0000
Subject: [PATCH v6 1/5] Extcon (external connector): import Android's
 switch class and modify.
In-Reply-To: <1330344939-18394-2-git-send-email-myungjoo.ham@samsung.com>
References: <1328856038-21912-1-git-send-email-myungjoo.ham@samsung.com>
 <1330344939-18394-1-git-send-email-myungjoo.ham@samsung.com>
 <1330344939-18394-2-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <20120309124119.GV3273@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 09:15:35PM +0900, MyungJoo Ham wrote:

> +#ifdef CONFIG_ANDROID
> +		extcon_class = class_create(THIS_MODULE, "switch");
> +#else /* !CONFIG_ANDROID */
> +		extcon_class = class_create(THIS_MODULE, "extcon");
> +#endif /* CONFIG_ANDROID */

This seems somewhat sad - if ANDROID is turned on the standard ABI
vanishes.  It'd be much nicer to do this with a symlink (or with
symlinks within the android directory if the driver core doesn't support
that).  That way userspace code can be written to the new ABI and will
work on Android systems without ifdefery.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120309/a0180f35/attachment-0001.sig>
