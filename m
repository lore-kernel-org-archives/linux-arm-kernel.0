From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 06 Jul 2011 14:56:36 +0300
Subject: [PATCH] Add 'config IMX_NFC_V1_BISWAP' to swap the Bad block
	Indicator, and use for imx27pdk nand support.
In-Reply-To: <19988.19315.787284.113228@ipc1.ka-ro>
References: <1309872828-13942-1-git-send-email-J.Lambrecht@televic.com>
	<20110706080942.GC26347@pengutronix.de> <4E142B18.60407@televic.com>
	<19988.19315.787284.113228@ipc1.ka-ro>
Message-ID: <1309953401.3149.87.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-07-06 at 13:48 +0200, Lothar Wa?mann wrote:
> You are mixing up two different things. The Bad block markers in
> certain locations in the OOB area mark 'Factory bad blocks'
> i.e. blocks that are already bad when you apply power to the flash for
> the first time. The manufacturer guarantees that initial bad blocks
> can be detected by checking those locations for a non-FF value.
> There is no guarantee that you may be able to write any specific value
> to a certain byte in a block that has turned bad due to wearout or
> whatever at any later time. Thus bad blocks that appear due to wearout
> should be kept track of in the BBT, not by writing any 'bad block
> markers' to the defective blocks themselves. 

That's a good point. In practice, though, many systems do not have a
separate BBT and they write a bad block marker to the OOB area of the
first page, or the second if the first page cannot be written. This
works. But yes, in theory, if an eraseblock became bad, there is a
possibility that you cannot write to the OOB areas anymore. However, as
I said, in practice, one of the OOBs is still writable. Hmm... Any
comments or practical observations?

-- 
Best Regards,
Artem Bityutskiy
