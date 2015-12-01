From: horms@verge.net.au (Simon Horman)
Date: Tue, 1 Dec 2015 15:41:50 +0900
Subject: [PATCH] ARM: shmobile: alt: Add QSPI device to DT
In-Reply-To: <CAMuHMdWnyZbHiLEPn-6dEweBEXHzWr6o2KF2iCpzg2-OhZRVSw@mail.gmail.com>
References: <1448863990-16276-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdWnyZbHiLEPn-6dEweBEXHzWr6o2KF2iCpzg2-OhZRVSw@mail.gmail.com>
Message-ID: <20151201064149.GH16260@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 09:34:10AM +0100, Geert Uytterhoeven wrote:
> On Mon, Nov 30, 2015 at 7:13 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Enable the QSPI controller in the alt device tree.
> >
> > Based similar work for the silk board by by Vladimir Barinov and
> > Sergei Shtylyov.
> >
> > Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> > Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Verified against Alt schematics and r8a7794 datasheet.
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> I can't verify the FLASH layout. Note that p.11 of
> ALT_MiniMonitor_Manual(SPI_Boot)_Rev0.01_e.pdf shows a different
> FLASH layout for the second and third partition.

Thanks. I see the following in v1.9.6 of the BSP[1]. Is it
the same as the document you referred to above?


		partition at 0 {
			label = "loader";
			reg = <0x00000000 0x00080000>;
			read-only;
		};
		partition at 40000 {
			label = "user";
			reg = <0x00080000 0x00580000>;
			read-only;
		};
		partition at 440000 {
			label = "flash";
			reg = <0x00600000 0x03a00000>;
		};


[1] https://git.kernel.org/cgit/linux/kernel/git/horms/renesas-backport.git/tree/arch/arm/boot/dts/r8a7794-alt.dts?h=rcar-gen2/v1.9.6&id=e1acbe074f36d96e901bf5346c50ee51da2ced42#n379
