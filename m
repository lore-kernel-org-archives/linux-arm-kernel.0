From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 09 Feb 2012 09:02:49 +0200
Subject: [PATCH 00/16] rmk's patch series for fixing OMAP
In-Reply-To: <20120209005334.GG25414@n2100.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <4F32DBB5.4010004@gmx.de>  <20120209005334.GG25414@n2100.arm.linux.org.uk>
Message-ID: <1328770969.1909.11.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-02-09 at 00:53 +0000, Russell King - ARM Linux wrote:

> Moreover, only last Monday did I enable the OMAP2 DSS subsystem on the
> 4430 SDP platform, _including_ the HDMI code, and looking at the commit
> it could be one of those platforms which is affected.
> 
> As I don't have a HDMI cable connected to the system, and I ran that
> kernel overnight, and I tried opening each /dev/fb* device, what I'm now
> wondering is: have I destroyed the HDMI PHY on my 4430SDP?

Probably not. I don't know the exact details of the HW bug (I wrote the
patch as it took too long for the person responsible for it to come up
with a decent patch), but my understanding is that the cable needs to be
plugged in at some point, and then removed.

Thinking about this now, I guess I should've sent queries to get a
proper description of the situation where the bug happens.

> However, you raise another point, a much more serious one at that.  Is
> this problem also present in 3.2?  The patch seems to apply almost cleanly
> to that kernel version, so I guess it is.  It fails to apply to v3.1
> because of missing files, so I guess 3.1 is unaffected.
> 
> So, why isn't this patch copied to the stable people?

Good point, I'll take it to the stable people.

The problem is present in all kernels where we have the HDMI driver, so
2.6.39+.

> For hardware destruction issues, once the problem has been identified, it
> should be shouted about very loudly to get it upstream as quickly as
> possible.  I'm sure Linus would've even taken it in patch form.
> 
> (You do realise that Linus does apply patches as well as pulling trees?)

Yes, I should've taken this directly to Linus.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120209/92321563/attachment.sig>
