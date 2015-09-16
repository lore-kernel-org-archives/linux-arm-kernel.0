From: damien.thebault@vitec.com (=?utf-8?B?RGFtaWVuIFRow6liYXVsdA==?=)
Date: Wed, 16 Sep 2015 06:53:57 +0000
Subject: NFS/TCP/IPv6 acting strangely in 4.2
In-Reply-To: <20150911113839.GO21084@n2100.arm.linux.org.uk>
References: <20150911113839.GO21084@n2100.arm.linux.org.uk>
Message-ID: <1442386435.3756.282.camel@vitec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-09-11 at 12:38 +0100, Russell King - ARM Linux wrote:
> I have a recent Marvell Armada 388 board here which uses the mvneta
> driver.  I'm seeing some weird effects with NFS with it acting as a
> client.

Hello,

I'm upgrading a Marvelle Armada 370 board using the mvneta driver from
4.0 to 4.2 and noticed issues with NFS booting.
Basically, most of the time init returns with an error code, or
programs segfault or throw illegal instructions.

Since it worked fine on 4.0 I bisected until I found commit
a84e32894191cfcbffa54180d78d7d4654d56c20 "net: mvneta: fix refilling
for Rx DMA buffers".

If I revert this commit, everything seems to get back to normal.
Could you try it ? The two issues look very similar.

Regards
-- 
Damien Th?bault
