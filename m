From: andy@greyhouse.net (Andy Gospodarek)
Date: Fri, 17 Mar 2017 09:58:36 -0400
Subject: [RFC arm64] samples/bpf: explicitly exclude sysreg sections with
 asm macros
In-Reply-To: <e842a237-9206-99ed-624b-4f3cf15cc557@arm.com>
References: <1489101492-15653-1-git-send-email-andy@greyhouse.net>
 <20170310175229.GC18894@arm.com>
 <20170310192656.GA13928@C02RW35GFVH8>
 <20170310204112.GA21382@leverpostej>
 <20170315183130.GB32819@C02RW35GFVH8.dhcp.broadcom.net>
 <20170315191741.GB29452@leverpostej>
 <20170315205404.GA43995@C02RW35GFVH8.dhcp.broadcom.net>
 <20170316104204.GA31101@leverpostej>
 <20170316210454.GA53792@C02RW35GFVH8.dhcp.broadcom.net>
 <e842a237-9206-99ed-624b-4f3cf15cc557@arm.com>
Message-ID: <20170317135836.GA58086@C02RW35GFVH8.dhcp.broadcom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 11:11:59AM +0000, Robin Murphy wrote:
> On 16/03/17 21:04, Andy Gospodarek wrote:
> > 
> > While I generally agree isn't the entire reason this inline asm exists
> > -- to fix a binutils issue?  :-)
> 
> Binutils is required to build the arm64 kernel; if certain versions of
> binutils packaged by arm64 distros can't cope with certain instructions
> we need to use, we have to do what we can to make it build. However, if
> LLVM cannot cope with inline assembly on arm64, then it's pretty clear
> that the kernel cannot be built with LLVM anyway, thus there is nothing
> to work around in that regard. Sorry, you've got a straw man there ;)

I know, right?  I'll see if I can come up with something that appears to
be less fragile and/or intrusive to the arm64 arch code as I'd really
like to stop carrying a patch in my devel tree for this.
