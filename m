From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Mar 2011 10:40:38 +0000
Subject: [PATCH] arm: cmpxchg syscall should data abort if page not
	write or not young
In-Reply-To: <1300098516-1601-1-git-send-email-ratbert.chuang@gmail.com>
References: <1300098516-1601-1-git-send-email-ratbert.chuang@gmail.com>
Message-ID: <20110314104038.GB26085@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2011 at 06:28:36PM +0800, Po-Yu Chuang wrote:
> From: Po-Yu Chuang <ratbert@faraday-tech.com>
> 
> If the page to cmpxchg is user mode read only (not write)
> or invalid (not young), we should simulate a data abort first.

No.  If it is not young then it should be made young.  Age is an effect
of accesses.  It's not a permission.
