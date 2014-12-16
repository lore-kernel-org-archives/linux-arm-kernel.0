From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Dec 2014 11:40:56 +0000
Subject: [PATCH] arm/rpc: avoid static keyword removal via define
In-Reply-To: <5490146A.3000408@de.ibm.com>
References: <1418633287-5019-1-git-send-email-borntraeger@de.ibm.com>
 <1418633287-5019-2-git-send-email-borntraeger@de.ibm.com>
 <5490146A.3000408@de.ibm.com>
Message-ID: <20141216114056.GP11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 12:15:54PM +0100, Christian Borntraeger wrote:
> Am 15.12.2014 um 09:48 schrieb Christian Borntraeger:
> > commit 4486b86368d7 ("[ARM] riscpc: fix decompressor font file handling")
> > introduced Makefile magic to avoid building a file two times. Using
> > -Dstatic= does break some assumptions on compiler.h that were introduced
> > for READ_ONCE.
> > 
> > Lets just use sed on the copy instead of using a define.
> > 
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> 
> This fixed the linux-next build http://kisskb.ellerman.id.au/kisskb/target/1508/
> Unless anybody complains, I will send the pull request for the access_once tree tomorrow and I have this patch applied on top.

Please give me some time to look at this.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
