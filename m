From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 26 Mar 2011 23:49:54 +0800
Subject: [PATCH] ARM: pxafb: Fix access to nonexistent member of pxafb_info
In-Reply-To: <201103231705.16164.anarsoul@gmail.com>
References: <1300796054-18697-1-git-send-email-marek.vasut@gmail.com>
	<201103231115.53082.anarsoul@gmail.com>
	<201103231554.36178.marek.vasut@gmail.com>
	<201103231705.16164.anarsoul@gmail.com>
Message-ID: <AANLkTimA3EmcLu2543PWwnriA2DTLKH4jDtajuRWTCS4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Merged with Vasily's Ack. On SoCs where there is no overlay HW yet
the support has been built into the kernel, the overlay[0/1].usage will
just be zero(s).

On Wed, Mar 23, 2011 at 11:05 PM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> On Wednesday 23 March 2011 16:54:36 Marek Vasut wrote:
>
>> Implement what ? The member doesn't exist in the structure so it doesn't
>> even compile with overlays disabled.
>
> Hm, sorry, I thought you also don't like that check is performed on SoCs
> without overlays (PXA250/PXA260) when overlay support is compiled in.
>
> I understand that it does not compile at all when CONFIG_FB_PXA_OVERLAY is not
> set.
>
> Regards
> Vasily
>
