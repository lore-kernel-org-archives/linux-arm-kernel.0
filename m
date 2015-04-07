From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Apr 2015 14:58:42 +0100
Subject: ARM errata 430973 on multi platform kernels
In-Reply-To: <CAALWOA93+ohYJ7Q06H4gVMywzP5=RC3uBkUVXjWMriRBoHzXKQ@mail.gmail.com>
References: <CAALWOA-h5SdnGhbckJ+x0efijmNaQxX-8ULjn_J=mCb-UJMeoQ@mail.gmail.com>
 <5520E2EE.4080302@gmail.com>
 <CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com>
 <5521A438.1070008@gmail.com>
 <CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com>
 <20150406151939.GG18048@atomide.com>
 <20150406154037.GI18048@atomide.com> <5522BEEF.2000405@gmail.com>
 <20150406174245.GJ18048@atomide.com>
 <CAALWOA93+ohYJ7Q06H4gVMywzP5=RC3uBkUVXjWMriRBoHzXKQ@mail.gmail.com>
Message-ID: <20150407135841.GM4027@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 06, 2015 at 08:14:30PM +0200, Matthijs van Duin wrote:
> * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [150406 10:15]:
> > Why custom function, if IBE bit is zero, BTB invalidate instruction is a
> > NOP. Do you think that "mcr p15, 0, r2, c7, c5, 6" executed as a NOP will
> > put so much overhead, that it deserves a custom function?
> 
> Executing them as nop is Cortex-A8 specific. On other ARMv7 CPUs, BTB
> invalidation on context switch may be unnecessary yet expensive.

That can be solved (see the patch I just posted) so I wouldn't worry
too much about that issue.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
