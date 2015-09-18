From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Sep 2015 16:20:51 +0100
Subject: [PATCH 0/7] Phy and mdiobus fixes
In-Reply-To: <20150918150128.GV2722@xsjsorenbubuntu>
References: <20150918094625.GB21084@n2100.arm.linux.org.uk>
 <20150918095600.GC21084@n2100.arm.linux.org.uk>
 <20150918150128.GV2722@xsjsorenbubuntu>
Message-ID: <20150918152050.GI21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 08:01:28AM -0700, S?ren Brinkmann wrote:
> Hi Russell,
> 
> On Fri, 2015-09-18 at 10:56AM +0100, Russell King - ARM Linux wrote:
> > Sorry guys, some of you will get the patches twice, as S?ren's name
> > in the header caused vger to reject all the patches.
> 
> That is the first time I hear about an issue like that. I've been
> receiving patches fine thus far and nobody reported any rejections (by
> vger) to me. Is it some bounce on Xilinx/my side or is vger suddenly
> rejecting non-ascii chars or is something in the mail processing chain
> not properly encoding those chars?
> Please, let me know if I can help with the problem.

It's to do with how I generate the patch set and submit it to my MTA.
The result is that the header fields contain an ?.  Almost all MTAs
accept this despite it being questionable, but zmailer is extra fussy
and rejects this - and rejected the messages to lkml, netdev, etc.

Normally, the MUA would encode "S?ren Brinkmann" in a header into a
7-bit ascii representation as "=?utf-8?B?U8O2cmVu?= Brinkmann".

It's one of the many issues of not using a MUA to send out patches.

It's also worth noting that git-send-email misses out mime headers
(or used to - which is why I have my own scripts for doing this)
which technically makes the bodies it mails out in violation of the
RFCs.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
