From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 19 Nov 2014 08:14:38 +1100
Subject: [PATCH] ARM: vfp: Silence mvfr0 unused variable warning
In-Reply-To: <1416344191-20484-1-git-send-email-sboyd@codeaurora.org>
References: <1416344191-20484-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20141119081438.3df66238@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Tue, 18 Nov 2014 12:56:31 -0800 Stephen Boyd <sboyd@codeaurora.org> wrote:
>
> Stephen Rothwell reports that commit 3f4c9f8f0a20 ("ARM: 8197/1:
> vfp: Fix VFPv3 hwcap detection on CPUID based cpus") introduced an
> unused variable warning.
> 
> arch/arm/vfp/vfpmodule.c: In function 'vfp_init':
> arch/arm/vfp/vfpmodule.c:725:6: warning: unused variable 'mvfr0'
> [-Wunused-variable]
>   u32 mvfr0;
> 
> Silence this warning by using IS_ENABLED instead of ifdefs.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Looks good (though I haven't tested it).  One small nit below:

> +		if (IS_ENABLED(CONFIG_VFPv3)) {
> +			mvfr0 = fmrx(MVFR0);

Now that you have a block here, you could move the declaration of mvfr0
into this block, right?

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141119/6805172a/attachment-0001.sig>
