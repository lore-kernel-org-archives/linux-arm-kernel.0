From: msalter@redhat.com (Mark Salter)
Date: Tue, 15 Oct 2013 11:20:04 -0400
Subject: arm64 ioremap question
Message-ID: <1381850404.27955.9.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ioremap() has a test to prevent RAM from being remapped:

	/*
	 * Don't allow RAM to be mapped.
	 */
	if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
		return NULL;


Is this really necessary even for reserved pages which are not being
used for anything else?

--Mark
