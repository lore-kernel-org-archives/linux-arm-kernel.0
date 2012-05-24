From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 24 May 2012 11:27:00 +0800
Subject: [PATCH 1/1] dma: imx-sdma: buf_tail should be initialize in
 prepare function
In-Reply-To: <20120524032026.GB17621@S2101-09.ap.freescale.net>
References: <1337603494-27464-1-git-send-email-richard.zhao@freescale.com>
 <20120524032026.GB17621@S2101-09.ap.freescale.net>
Message-ID: <20120524032659.GA19682@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2012 at 11:20:29AM +0800, Shawn Guo wrote:
> On Mon, May 21, 2012 at 08:31:34PM +0800, Richard Zhao wrote:
> > This fix audio underrun issue. When SNDRV_PCM_TRIGGER_STOP
> > and SNDRV_PCM_TRIGGER_START, it calls prepare again. buf_tail
> > should be reset to zero.
> > So move buf_tail initialization into prepare function.
> > 
> I tried the patch on imx51, and it does not fix the issue for me.
> 
> Regards,
> Shawn
> 
> root at linaro-developer:~# aplay audio8k16S.wav
> Playing WAVE 'audio8k16S.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Stere
> o
> ^Z
> [1]+  Stopped                 aplay audio8k16S.wav
> root at linaro-developer:~# fg
> aplay audio8k16S.wav
> underrun!!! (at least 2034.382 ms long)
Does the audio playback recover? Without the patch, sometimes the
playback will have distortion and play too fast.

Thanks
Richard 
