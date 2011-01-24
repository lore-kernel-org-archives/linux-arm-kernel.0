From: dave@linux.vnet.ibm.com (Dave Hansen)
Date: Mon, 24 Jan 2011 10:47:37 -0800
Subject: [PATCH] ARM: mm: Regarding section when dealing with meminfo
In-Reply-To: <20110124175807.GA27427@n2100.arm.linux.org.uk>
References: <1295516739-9839-1-git-send-email-pullip.cho@samsung.com>
	<1295544047.9039.609.camel@nimitz>
	<20110120180146.GH6335@n2100.arm.linux.org.uk>
	<1295547087.9039.694.camel@nimitz>
	<20110123180532.GA3509@n2100.arm.linux.org.uk>
	<1295887937.11047.119.camel@nimitz>
	<20110124175807.GA27427@n2100.arm.linux.org.uk>
Message-ID: <1295894857.11047.556.camel@nimitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-01-24 at 17:58 +0000, Russell King - ARM Linux wrote:
> Wrong.  For flatmem, we have a pfn_valid() which is backed by doing a
> one, two or maybe rarely three compare search of the memblocks.  Short
> of having a bitmap of every page in the 4GB memory space, you can't
> get more efficient than that.

Sweet.  So, we can just take the original patch that started this
conversation, add the requisite pfn_valid()s and pfn_to_page()s, and
skip the sparsemem #ifdefs.  Right?

-- Dave
