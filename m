From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 22 Feb 2014 10:22:21 +0000
Subject: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
In-Reply-To: <530847E3.4070401@ti.com>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
 <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
 <20140219193315.3732.21819@capellas-linux>
 <20140220162754.GC15994@e102568-lin.cambridge.arm.com>
 <20140221183956.29890.80931@capellas-linux>
 <20140221235911.14777.13919@capellas-linux>
 <20140222043714.19852.67450@capellas-linux> <530847E3.4070401@ti.com>
Message-ID: <20140222102221.GF21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 10:46:59PM -0800, Russ Dill wrote:
> If there is worry about this, you could setup a page mapping in a
> __nosave region, preventing it from being overwritten.

Why would we need _another_ set of pages tables?  Aren't two (swapper_pg_dir
and the idmap one) enough?

You do need to switch to the idmap one if you're going to call cpu_resume
at its physical address, because that requires the identity mapping in
order to work.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
