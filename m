From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Mon, 12 Mar 2012 23:30:21 +0400
Subject: [PATCH v2 2/2] arm/tegra: add timeout to PCIe PLL lock detection
 loop
In-Reply-To: <4F5E3BE7.4080207@wwwdotorg.org>
References: <20120306201538.GA14350@rainbow>
 <1331287760-10546-1-git-send-email-mad_soft@inbox.ru>
 <4F5E3BE7.4080207@wwwdotorg.org>
Message-ID: <20120312193020.GA1584@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:09 Mon 12 Mar     , Stephen Warren wrote:
> Thierry pointed out that one of NVIDIA's downstream kernels uses a
> timeout of 300 here, rather than 2000 above. Do you see a specific need
> for this timeout for be 2000 rather than 300? It might be nice to be
> consistent.
No, there's no specific need for it to be 2000 - it may as well be 300.
I just wanted to stay on the safe side, but I think 300 should be still
more than enough time for PLL to lock.

> 
> Olof, I notice you've already applied V1 of this, which has the return
> statement issue. Can you replace it with this, or should Dmitry send an
> incremental patch?

Yes, V1 breaks more things than it fixes, so it would be nice if
it can be replaced with fixed version (I hope it's not too late yet).
BTW, regarding timeout discussion above - should I resend patch with
adjusted timeout, or can you change it while applying? (of course,
if we settle on incremental patch, I'll roll this change in)

-- 
Best regards,
Dmitry "MAD" Artamonow
