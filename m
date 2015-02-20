From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Feb 2015 13:38:06 +0000
Subject: Announce: rmk's nightly builder gets ARM64 support
In-Reply-To: <CAOMZO5Aqx_SQ1oaML=hiVzzJMJ2bNTAsjk-dWFLkETaV4_JO+A@mail.gmail.com>
References: <20150219171220.GA8656@n2100.arm.linux.org.uk>
 <20150219183444.GB8656@n2100.arm.linux.org.uk>
 <20150220092003.GB31692@arm.com>
 <CAKv+Gu_5fOinMVYbk99unmEDSqCF3Z7QdXiQTw0VrrWW16Oc6w@mail.gmail.com>
 <20150220094035.GE8656@n2100.arm.linux.org.uk>
 <20150220102009.GF8656@n2100.arm.linux.org.uk>
 <CAOMZO5Aqx_SQ1oaML=hiVzzJMJ2bNTAsjk-dWFLkETaV4_JO+A@mail.gmail.com>
Message-ID: <20150220133806.GG8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 08:35:31AM -0200, Fabio Estevam wrote:
> Hi Russell,
> 
> On Fri, Feb 20, 2015 at 8:20 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > Note that it would also be useful to know where to get a working gcc
> > from (preferably in source form - I doubt there's any Fedora 14
> > binaries around.)
> 
> The kbuild robot uses the following method:
> 
> wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross
> -O ~/bin/make.cross
> chmod +x ~/bin/make.cross
> 
> make.cross ARCH=arm64  defconfig
> make.cross ARCH=arm64
> 
> This builds 3.19 fine.

>From what I can see, this doesn't _build_ a compiler.  It grabs
gcc-linaro-aarch64-linux-gnu-4.9-2014.08_linux.tar.xz from
http://releases.linaro.org/14.08/components/toolchain/binaries
and installs that - which contains a load of binaries.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
