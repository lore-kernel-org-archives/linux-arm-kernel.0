From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 15 Jan 2013 18:05:15 +1300
Subject: [PATCH 2/4] serial: vt8500: ioremap'd resource is never freed
In-Reply-To: <1358225886-5686-3-git-send-email-linux@prisktech.co.nz>
References: <1358225886-5686-1-git-send-email-linux@prisktech.co.nz>
 <1358225886-5686-3-git-send-email-linux@prisktech.co.nz>
Message-ID: <1358226315.5576.3.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-01-15 at 17:58 +1300, Tony Prisk wrote:
> Memory mapped via ioremap call is never released. Rather than add an
> iounmap call, change allocation function to devm_request_and_ioremap.
> 
> Also, change the error on failure for this call to -EBUSY rather than
> -EADDRNOTAVAIL.

Grr.. I thought I fixed this typo before I sent the patch.
I'll send another version but I'll wait for feedback on the series
first.

Regards
Tony P
