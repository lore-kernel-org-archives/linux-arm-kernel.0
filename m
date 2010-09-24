From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 24 Sep 2010 13:35:38 +0200
Subject: PXA270 audio problem
In-Reply-To: <AANLkTikerg6JUt8Kv5M9N1UbHaQE6seeiSYdSVOoNghb@mail.gmail.com>
References: <AANLkTi=_AANevVpthOKuRfkkvU9mKMWsmpHc+XohoUwg@mail.gmail.com>
	<AANLkTimRPZijUXcecbBSexuthttJ76-NYVbs0cc3iyZm@mail.gmail.com>
	<AANLkTikerg6JUt8Kv5M9N1UbHaQE6seeiSYdSVOoNghb@mail.gmail.com>
Message-ID: <201009241335.38801.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 23. z??? 2010 09:24:51 Santhosh N napsal(a):
> Hi,
> 
> Following is the way I reach the no audio playback state.
> 
> I have put a loop in a shell script and play a short mp3 file
> repeatedly. The no audio playback state is reached sometimes very
> quickly and sometimes after a while.

Can you try more up-to-date kernel ? There were many changes in ucb1400 driver 
happening
> 
> Regards,
> Santhosh N
> 
> On Thu, Sep 23, 2010 at 12:35 PM, Santhosh N <san.mlists@gmail.com> wrote:
> > Hi,
> > 
> > Following are the AC97 and DMA register dumps. I am printing out the
> > DMA registers from the pxa2xx_pcm_trigger function.
> > 
> > I have noticed that, the touchscreen and audio record continues to
> > work after the problem. In the problem state, the DMA interrupts occur
> > for audio record but not for playback.
> > 
> > AC97:
> > BeforeProblem                   AfterProblem
> > 0:00 = 02a0                     0:00 = 02a0
> > 0:02 = 0d0d                     0:02 = 0d0d
> > 0:04 = 0000                     0:04 = 0000
> > 0:06 = 0000                     0:06 = 0000
> > 0:08 = 0000                     0:08 = 0000
> > 0:0a = 0000                     0:0a = 0000
> > 0:0c = 0000                     0:0c = 0000
> > 0:0e = 0000                     0:0e = 0000
> > 0:10 = 0000                     0:10 = 0000
> > 0:12 = 0000                     0:12 = 0000
> > 0:14 = 0000                     0:14 = 0000
> > 0:16 = 0000                     0:16 = 0000
> > 0:18 = 0000                     0:18 = 0000
> > 0:1a = 0000                     0:1a = 0000
> > 0:1c = 0000                     0:1c = 0000
> > 0:1e = 0000                     0:1e = 0000
> > 0:20 = 0000                     0:20 = 0000
> > 0:22 = 0000                     0:22 = 0000
> > 0:24 = 0000                     0:24 = 0000
> > 0:26 = 000b                     0:26 = 000b
> > 0:28 = 0001                     0:28 = 0001
> > 0:2a = 0001                     0:2a = 0001
> > 0:2c = 5622                     0:2c = 3e80
> > 0:2e = 0000                     0:2e = 0000
> > 0:30 = 0000                     0:30 = 0000
> > 0:32 = bb80                     0:32 = bb80
> > 0:34 = 0000                     0:34 = 0000
> > 0:36 = 0000                     0:36 = 0000
> > 0:38 = 0000                     0:38 = 0000
> > 0:3a = 0000                     0:3a = 0000
> > 0:3c = 0000                     0:3c = 0000
> > 0:3e = 0000                     0:3e = 0000
> > 0:40 = 0000                     0:40 = 0000
> > 0:42 = 0000                     0:42 = 0000
> > 0:44 = 0000                     0:44 = 0000
> > 0:46 = 0000                     0:46 = 0000
> > 0:48 = 0000                     0:48 = 0000
> > 0:4a = 0000                     0:4a = 0000
> > 0:4c = 0000                     0:4c = 0000
> > 0:4e = 0000                     0:4e = 0000
> > 0:50 = 0000                     0:50 = 0000
> > 0:52 = 0000                     0:52 = 0000
> > 0:54 = 0000                     0:54 = 0000
> > 0:56 = 0000                     0:56 = 0000
> > 0:58 = 0000                     0:58 = 0000
> > 0:5a = 0000                     0:5a = 0000
> > 0:5c = 0000                     0:5c = 0000
> > 0:5e = 0000                     0:5e = 0000
> > 0:60 = 0000                     0:60 = 0000
> > 0:62 = 0000                     0:62 = 0000
> > 0:64 = 0948                     0:64 = 0948
> > 0:66 = 0000                     0:66 = 0000
> > 0:68 = 824b                     0:68 = 824b
> > 0:6a = 0050                     0:6a = 0050
> > 0:6c = 0030                     0:6c = 0030
> > 0:6e = 2004                     0:6e = 2004
> > 0:70 = 0000                     0:70 = 0000
> > 0:72 = 0000                     0:72 = 0000
> > 0:74 = 0000                     0:74 = 0000
> > 0:76 = 0000                     0:76 = 0000
> > 0:78 = 0000                     0:78 = 0000
> > 0:7a = 0000                     0:7a = 0000
> > 0:7c = 5053                     0:7c = 5053
> > 0:7e = 4304                     0:7e = 4304
> > 
> > Only diff in the above is in the 02C(Audio sample rate control) register.
> > 
> > DMA:
> > BeforeProblem
> > 
> > ::: DMA Channel: 8, Trigger Start
> > 
> > DDADR = 0xB714A010
> > DSADR = 0xB7100040
> > DTADR = 0x40500040
> > DCMD  = 0x9023CFC0
> > DCSR  = 0x80000000
> > 
> > ::: DMA Channel: 8, Trigger Stop
> > 
> > DDADR = 0xB714A0E0
> > DSADR = 0xB710D000
> > DTADR = 0x40500040
> > DCMD  = 0x9023D000
> > DCSR  = 0x00000008
> > 
> > 
> > AfterProblem
> > 
> > ::: DMA Channel: 8, Trigger Start
> > 
> > DDADR = 0xB70B7010
> > DSADR = 0xB7100000
> > DTADR = 0x40500040
> > DCMD  = 0x9023D000
> > DCSR  = 0x80000000
> > ALSA sound/core/pcm_native.c:1512: playback drain error (DMA or IRQ
> > trouble?)
> > 
> > ::: DMA Channel: 8, Trigger Stop
> > 
> > DDADR = 0xB70B7010
> > DSADR = 0xB7100000
> > DTADR = 0x40500040
> > DCMD  = 0x9023D000
> > DCSR  = 0x00000008
> > 
> > Each dump above is after playing a mp3 file using madplay.
> > 
> > Regards,
> > Santhosh N
> > 
> > On Thu, Sep 23, 2010 at 11:38 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> >> On Thu, Sep 23, 2010 at 1:33 PM, Santhosh N <san.mlists@gmail.com> wrote:
> >>> Dear All,
> >>> 
> >>> I am running linux 2.6.26 kernel on a PXA270 board. A UCB1400 chip
> >>> used for audio and touchscreen in that. I have been facing a problem
> >>> with audio.
> >>> 
> >>> The audio plays properly, but suddenly stops. I get the following
> >>> message: ALSA sound/core/pcm_native.c:1513: playback drain error (DMA
> >>> or IRQ trouble?)
> >>> 
> >>> I have noticed that the DMA interrupts stop coming. Where as the AC97
> >>> interrupts come properly.
> >>> 
> >>> Any help in solving this will be grateful.
> >> 
> >> Dumping the DMA registers and the AC97 controller registers would
> >> be helpful.
> >> 
> >>> Regards,
> >>> Santhosh N
> >>> 
> >>> _______________________________________________
> >>> linux-arm-kernel mailing list
> >>> linux-arm-kernel at lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
