From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 8 Jan 2018 18:22:20 +0000
Subject: [v2,03/11] arm64: Take into account ID_AA64PFR0_EL1.CSV3
In-Reply-To: <20180108175100.GW25869@arm.com>
References: <1515157961-20963-4-git-send-email-will.deacon@arm.com>
 <20180108072253.GA178830@jc-sabre>
 <9bc1f137-d78c-e46e-e1bc-f49160d5f289@arm.com>
 <20180108174016.GB180149@jc-sabre> <20180108175100.GW25869@arm.com>
Message-ID: <20180108182220.34233ebc@alans-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > On systems that are not vulnerable to variant 3, this is an unnecessary
> > overhead.  
> 
> KASLR can be bypassed on CPUs that are not vulnerable to variant 3 simply
> by timing how long accesses to kernel addresses from EL0 take -- please read
> the original KAISER paper for details about that attack on x86. kpti
> mitigates that. If you don't care about KASLR, don't enable it (arguably
> it's useless without kpti).

KASLR is primarily of value for remote protection.

Alan
