From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Aug 2014 11:20:21 +0100
Subject: [PATCH v5 1/3] ARM: probes: check stack operation when decoding
In-Reply-To: <53FEFB93.2010009@hitachi.com>
References: <1409144552-12751-1-git-send-email-wangnan0@huawei.com>
 <1409144552-12751-2-git-send-email-wangnan0@huawei.com>
 <53FEFB93.2010009@hitachi.com>
Message-ID: <20140828102021.GC30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 06:51:15PM +0900, Masami Hiramatsu wrote:
> (2014/08/27 22:02), Wang Nan wrote:
> > This patch improves arm instruction decoder, allows it check whether an
> > instruction is a stack store operation. This information is important
> > for kprobe optimization.
> > 
> > For normal str instruction, this patch add a series of _SP_STACK
> > register indicator in the decoder to test the base and offset register
> > in ldr <Rt>, [<Rn>, <Rm>] against sp.
> > 
> > For stm instruction, it check sp register in instruction specific
> > decoder.
> 
> OK, reviewed. but since I'm not so sure about arm32 ISA,
> I need help from ARM32 maintainer to ack this.

What you actually need is an ack from the ARM kprobes people who
understand this code.  That would be much more meaningful than my
ack.  They're already on the Cc list.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
