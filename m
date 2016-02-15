From: sebott@linux.vnet.ibm.com (Sebastian Ott)
Date: Mon, 15 Feb 2016 17:38:43 +0100 (CET)
Subject: [BUG] random kernel crashes after THP rework on s390 (maybe also
 on PowerPC and ARM)
In-Reply-To: <20160215113159.GA28832@node.shutemov.name>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name> <56BE00E7.1010303@de.ibm.com>
 <20160212181640.4eabb85f@thinkpad>
 <20160212231510.GB15142@node.shutemov.name>
 <alpine.LFD.2.20.1602131238260.1910@schleppi>
 <20160215113159.GA28832@node.shutemov.name>
Message-ID: <alpine.LFD.2.20.1602151736120.1820@schleppi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Feb 2016, Kirill A. Shutemov wrote:
> > [   59.851421] list_del corruption. next->prev should be 000000006e1eb000, but was 0000000000000400
> 
> This kinda interesting: 0x400 is TAIL_MAPPING.. Hm..
> 
> Could you check if you see the problem on commit 1c290f642101 and its
> immediate parent?

Both 1c290f642101 and 1c290f642101^ survived 20 compile runs each.

Sebastian
