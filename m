From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Apr 2013 10:05:59 +0100
Subject: [RFC] arm64: Early printk support for virtio-mmio console devices.
In-Reply-To: <CAAHg+HhtCorArCmx=ha0=64+SJZiizzrDUKSPLV=N+OzO8zAxQ@mail.gmail.com>
References: <1366264344-28025-1-git-send-email-pranavkumar@linaro.org>
 <ede8ee08bb2616c2ed642200e3357367@localhost>
 <CAAHg+HhajHFC=1nh6YQNgpf=Na2FqcsYJ=t+ag9QiTg6TxUz9w@mail.gmail.com>
 <bb1193983de3ea9f4df1a570441df34c@localhost>
 <CAAHg+HhtCorArCmx=ha0=64+SJZiizzrDUKSPLV=N+OzO8zAxQ@mail.gmail.com>
Message-ID: <20130419090558.GA13283@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Apr 18, 2013 at 09:48:49AM +0100, Pranavkumar Sawargaonkar wrote:
> Actually i thought adding a config register will be easier to add a
> code than writing entire emulation as 8250 emulation will require to
> deal with dealing with more registers and more code.

kvmtool already has an 8250 emulation! All we need to do is hack together
something which will allow us to instantiate those ioport devices in a more
flexible manner (namely, inside the MMIO space for ARM). For earlyprintk, I
suspect we can get away without an interrupt too, which should simplify
things a bit to start with.

Regardless of the outcome of this discussion, I think getting the 8250
working on ARM is definitely something worth doing. If I get time, I'll take
a look.

Will
