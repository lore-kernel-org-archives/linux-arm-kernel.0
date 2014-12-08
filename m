From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 8 Dec 2014 23:06:55 +0100
Subject: nokia_h4p on 3.16+
In-Reply-To: <20141208204735.GA21599@amd>
References: <20141208204735.GA21599@amd>
Message-ID: <201412082306.55505@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 December 2014 21:47:35 Pavel Machek wrote:
> Hi!
> 
> It seems commit:
> 
> commit bd5dc09f557547399cd44d0a1224df7ff64e4a6b
> Author: Felipe Balbi <balbi@ti.com>
> Date:   Wed Apr 23 09:58:28 2014 -0500
> 
>     serial: fix UART_IIR_ID
> 
>     UART IRQ Identification bitfield is 3
>         bits long (bits 3:1) but current mask only
> 	    masks 2 bits. Fix it.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> breaks bluetooth driver on n900. (drivers/staging/nokia_h4p).
> 
> Pali, you may want to revert the patch.
> 
> That is good news, because reverting it on 3.18-rcX brings h4p
> back, too (and as machine boots on nfsroot, debugging should
> be possible.)
> 
> Best regards,
> 									Pavel

Reverted in linux-n900 git tree in v3.18-rc6-n900 branch.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141208/688fd333/attachment-0001.sig>
