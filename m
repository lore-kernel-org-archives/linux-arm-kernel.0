From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 27 Oct 2011 11:03:48 +0200
Subject: [RFC] DT boot loader best practice
Message-ID: <20111027090348.GA4059@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	For ARM it's important to use the DT in the bootloader the right way.
	In oder to do not have to add crapy fixup in the kernel to fix bad practice in
	bootloader

	For this is this what is not supposed to done
	- Hardcode the DTB in the bootloader
	- Generate the DTB in the bootloader
	- Update the DTB in the bootloader (except the ATAG equivalent part)

	as all of this will give no control of update the DTB content or
	format. If some bootloader implementation mess-up with property name
	as they do it before be review, we will have to do fix up in the
	kernel. Which we absolutely not want to do.

Best Regards,
J.
