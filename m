From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Thu, 30 Nov 2017 11:41:34 +0900
Subject: do page fault in atomic bug on arm
In-Reply-To: <20171128095204.GR31757@n2100.armlinux.org.uk>
References: <d83cdbf1-0d27-fb82-14c8-3d37101c3c06@linaro.org>
 <20171121132001.GH31757@n2100.armlinux.org.uk>
 <64cbcda0-d040-4872-4a6b-7cd18375b4aa@linaro.org>
 <20171124192700.GU31757@n2100.armlinux.org.uk>
 <20171124202553.GV31757@n2100.armlinux.org.uk>
 <08bb4658-5b62-e306-5aa8-366be25986ca@linaro.org>
 <20171127104034.205fc0b50e9bf9dafdcd05c7@kernel.org>
 <20171127133631.GE19413@lunn.ch>
 <20171127135523.GE31757@n2100.armlinux.org.uk>
 <20171128145221.facdf1b4d74dd029f1edcb83@kernel.org>
 <20171128095204.GR31757@n2100.armlinux.org.uk>
Message-ID: <20171130114134.599e406afe19543fd5924e24@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Nov 2017 09:52:05 +0000
Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Tue, Nov 28, 2017 at 02:52:21PM +0900, Masami Hiramatsu wrote:
> > So there is already NOKPROBE_SYMBOL() macro to make a blacklist so that
> > we can avoid such recursive faults. We need to identify such place and
> > put the symbols in it as I did on x86.
> 
> Only if they are C functions.  If they're assembly, NOKPROBE_SYMBOL()
> doesn't work.  The answer there is to move them into a section that
> is excluded from kprobing.  That's what the second patch I've already
> sent does.

Thanks!

And if you need to put some symbols in assembly which already in 
another section, you can use _ASM_NOKPROBE(symbol) macro :)


> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up


-- 
Masami Hiramatsu <mhiramat@kernel.org>
