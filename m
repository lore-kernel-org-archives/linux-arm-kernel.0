From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 May 2011 04:23:53 -0700
Subject: [PATCHv3] ARM:boot:device tree: Allow the device tree binary
	to be appended to zImage
In-Reply-To: <20110324231830.2586.7150.stgit@riker>
References: <20110324231830.2586.7150.stgit@riker>
Message-ID: <20110509112353.GB11410@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* John Bonesio <bones@secretlab.ca> [110324 16:17]:
> This patch provides the ability to boot using a device tree that is appended
> to the raw binary zImage (e.g. cat zImage <filename>.dtb > zImage_w_dtb).

I suggest adding something like this to the description:

Note that a follow-up patch is needed to add checking for
kernel BSS overlapping the device tree data.

Other than that, I got /proc/device-tree entries showing up with
this patch + the uncompress fixes + the kernel BSS check I posted
as a reply to this thread, so:

Tested-by: Tony Lindgren <tony@atomide.com>
