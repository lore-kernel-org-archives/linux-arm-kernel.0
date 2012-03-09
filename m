From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Mar 2012 11:53:31 +0000
Subject: [PATCH v3 08/11] ASoC: fsl: make fsl_ssi driver compilable on
 ARM/IMX
In-Reply-To: <20120309032128.GK2499@S2101-09.ap.freescale.net>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-9-git-send-email-shawn.guo@linaro.org>
 <4F5912D0.2090800@freescale.com>
 <20120309012653.GG2499@S2101-09.ap.freescale.net>
 <4F596674.5030405@freescale.com>
 <20120309032128.GK2499@S2101-09.ap.freescale.net>
Message-ID: <20120309115327.GD3273@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2012 at 11:21:31AM +0800, Shawn Guo wrote:
> On Fri, Mar 09, 2012 at 02:09:57AM +0000, Tabi Timur-B04825 wrote:

> > That's the general idea, but I think it needs more study.  I don't 
> > consider this to be a bug that needs to be fixed ASAP, since it's never 
> > been an actual problem so far.  For instance, do we need to protect 
> > between hw_params and _trigger?

Yes, the capture and playback streams may run in parallel.

> Ok, I will leave it to you with a big "FIXME" comment then.

You probably just need a read/modify/write function to do the locking in
the style of update_bits().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120309/1a035262/attachment-0001.sig>
