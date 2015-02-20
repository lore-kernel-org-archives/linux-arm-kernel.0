From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 20 Feb 2015 16:02:24 -0200
Subject: Announce: rmk's nightly builder gets ARM64 support
In-Reply-To: <20150220175931.GL8656@n2100.arm.linux.org.uk>
References: <20150219171220.GA8656@n2100.arm.linux.org.uk>
 <20150219183444.GB8656@n2100.arm.linux.org.uk>
 <20150220092003.GB31692@arm.com>
 <CAKv+Gu_5fOinMVYbk99unmEDSqCF3Z7QdXiQTw0VrrWW16Oc6w@mail.gmail.com>
 <20150220094035.GE8656@n2100.arm.linux.org.uk>
 <20150220102009.GF8656@n2100.arm.linux.org.uk>
 <CAOMZO5Aqx_SQ1oaML=hiVzzJMJ2bNTAsjk-dWFLkETaV4_JO+A@mail.gmail.com>
 <20150220133806.GG8656@n2100.arm.linux.org.uk>
 <CAOMZO5BgrWGciKt0pjpbtX4wP0CgWWN39BcSjnSD89MxKEpBCg@mail.gmail.com>
 <20150220140440.GF31692@arm.com>
 <20150220175931.GL8656@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5CkQD=d9f_Bh-+s1iz3-ct-JfCxVgqMmcb43kzadgcWFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 3:59 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> There's a number of warnings in drivers/pci/host/pci-xgene.c which
> look like they need resolving - returning NULL from a function which
> returns an 'int' has never been valid - has this commit (which seems
> to have introduced the problem) actually been tested?
>
> Maybe xgene_pcie_map_bus() is supposed to return a void * ?

Correct. I have already sent a patch for this:
http://www.spinics.net/lists/linux-pci/msg38743.html
