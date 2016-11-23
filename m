From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Nov 2016 21:17:45 +0000
Subject: ath9k ARMv7 OOPS in v4.8.6, v4.2.8
In-Reply-To: <20161123205917.GI2799@io.lakedaemon.net>
References: <20161123191539.GF2799@io.lakedaemon.net>
 <20161123195120.GE14217@n2100.armlinux.org.uk>
 <20161123205917.GI2799@io.lakedaemon.net>
Message-ID: <20161123211745.GF14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2016 at 08:59:17PM +0000, Jason Cooper wrote:
> As requested on irc:

Thanks.

>      7f0:	ea000002 	b	800 <ath_cmn_process_fft+0xac>
>      7f4:	e7970102 	ldr	r0, [r7, r2, lsl #2]
>      7f8:	ebfffffe 	bl	0 <relay_buf_full>
>      7fc:	e0844000 	add	r4, r4, r0
>      800:	e300a000 	movw	sl, #0
>      804:	e28b2001 	add	r2, fp, #1
>      808:	e340a000 	movt	sl, #0
>      80c:	e3a01004 	mov	r1, #4
>      810:	e1a0000a 	mov	r0, sl
>      814:	ebfffffe 	bl	0 <_find_next_bit_le>
>      818:	e5953000 	ldr	r3, [r5]
>      81c:	e1500003 	cmp	r0, r3
>      820:	e1a0b000 	mov	fp, r0
>      824:	e2802008 	add	r2, r0, #8
>      828:	bafffff1 	blt	7f4 <ath_cmn_process_fft+0xa0>

Okay, so i was 0, so running UP probably isn't going to help.  r7 is
also spec_priv->rfs_chan_spec_scan.

So, I think the question is... how is this NULL - and has it always
been NULL...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
