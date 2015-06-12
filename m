From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Fri, 12 Jun 2015 21:44:39 +0200
Subject: [PATCH v4 1/6] mtd: nand: vf610_nfc: Freescale NFC for VF610,
 MPC5125 and others
In-Reply-To: <16ebb290641f700f2262527f90ff1e46@agner.ch>
References: <1427300909-20825-1-git-send-email-stefan@agner.ch>
 <1427300909-20825-2-git-send-email-stefan@agner.ch>
 <20150603130825.GA23991@breakpoint.cc>
 <b3b09b4b8c97cbfc88fa0d5fdc5e40cd@agner.ch>
 <20150609200751.GC5720@breakpoint.cc>
 <16ebb290641f700f2262527f90ff1e46@agner.ch>
Message-ID: <20150612194439.GA15327@breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-06-09 22:31:07 [+0200], Stefan Agner wrote:
> > have the endian swap. So an abstraction like you provided earlier
> > would be nice :)
> 
> What do you mean by that?

Something like you did for the reader where you have:

|static inline u32 vf610_nfc_read(struct vf610_nfc *nfc, uint reg)
|{
|	return readl(nfc->regs + reg);
|}

instead using readl() directly. So you could also have

|static inline u32 vf610_nfc_read_relaxed(struct vf610_nfc *nfc, uint reg)
|{
|	return readl_relaxed(nfc->regs + reg);
|}

Instead of using readl_relaxed(). Unless I'm mistaken, that function was
used more than once. If someone plugs in PPC support he does not need to
add this function anymore but but simply add an ifdef in vf610_nfc_read()
and vf610_nfc_read_relaxed() and replace it whatever works for him.

Sebastian
