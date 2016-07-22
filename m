From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 22 Jul 2016 09:27:40 +0200
Subject: [PATCH] i2c: bcm2835: Set up the clock stretching timeout at boot.
In-Reply-To: <87lh1ip653.fsf@eliezer.anholt.net>
References: <1464818845-5348-1-git-send-email-eric@anholt.net>
 <20160704003118.GA1381@tetsubishi>
 <87lh1ip653.fsf@eliezer.anholt.net>
Message-ID: <20160722072740.GG1605@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 03, 2016 at 06:02:32PM -0700, Eric Anholt wrote:
> Wolfram Sang <wsa@the-dreams.de> writes:
> 
> >> +	/*
> >> +	 * SMBUS says "Devices participating in a transfer will
> >> +	 * timeout when any clock low exceeds the value of
> >> +	 * T_TIMEOUT,MIN of 25 ms."
> >> +	 */
> >
> > SMBus has that timeout, but I2C doesn't. How about disabling the timeout
> > simply? Or using the max value if you want to keep the timeout
> > detection?
> 
> Disabling the timeout seems fine to me.  We still have a 1-second
> timeout around the entire transfer.  I'll be back on my DSI branch this
> week and test it out then.

Did it work?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160722/f1cb495b/attachment.sig>
