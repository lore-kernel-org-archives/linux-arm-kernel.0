From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Jul 2013 15:18:06 +0200
Subject: [PATCH] arm: update advice on kernel and FDT load address.
In-Reply-To: <20130730094118.GF11527@mudshark.cambridge.arm.com>
References: <1375102578-5869-1-git-send-email-ian.campbell@citrix.com>
 <20130729135000.GK32383@mudshark.cambridge.arm.com>
 <1375106635.12741.8.camel@kazak.uk.xensource.com>
 <alpine.LFD.2.03.1307292234040.15022@syhkavp.arg>
 <20130730094118.GF11527@mudshark.cambridge.arm.com>
Message-ID: <20130730151806.33ee3081@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Will Deacon,

On Tue, 30 Jul 2013 10:41:18 +0100, Will Deacon wrote:

> > The initial page table is therefore (in most cases again) just below the 
> > decompressed kernel location i.e. either Ffrom 16KB from start of RAM, 
> > or from 12KB if using LPAE.
> > 
> > You can therefore load everything (zImage, initrd, DTB) sequentially 
> > from the 32MB mark in RAM and be safe.  By loading zImage that high, it 
> > most certainly won't need to relocate itself (unless the decompressed 
> > kernel is larger than 32MB which is very unlikely as I mentioned) and 
> > that will also make the boot process slightly faster.
> 
> Hmm, how does that work with CONFIG_INITRAMFS_SOURCE, where the initramfs
> is built into the zImage? Would this impose a 32MB uncompressed limit on the
> size of the kernel + initramfs?

I've recently had troubles with a kernel + bundled initramfs, when the
compressed size of both exceeds something like 6 MB or so. I haven't
done any serious testing as compressing with XZ worked around the
problem, but I think there's some limit somewhere, but I guess 6 MB
compressed isn't going to expand to 32 MB uncompressed so I'm not sure
it's the limit you're referring to that I'm seeing.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
