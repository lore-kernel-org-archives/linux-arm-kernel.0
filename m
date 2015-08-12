From: stefan@agner.ch (Stefan Agner)
Date: Thu, 13 Aug 2015 01:03:51 +0200
Subject: [PATCH v5] ARM: early fixmap support for earlycon
In-Reply-To: <1439309753-30864-1-git-send-email-stefan@agner.ch>
References: <1439309753-30864-1-git-send-email-stefan@agner.ch>
Message-ID: <be21734a76bbc844d3035b3bf3a1ad6c@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-08-11 18:15, Stefan Agner wrote:
<snip>
> Hi Russel,
> 
> All three compile issues were related to MMU/!MMU differences. The solution
> is rather simple: This patch now only configures FIX_EARLYCON_MEM if the
> MMU is available. This makes sense since on !MMU platform we can use ioremap
> very early...
> 
> --
> Stefan
> 
> Changes since v4:
> - Add MMU dependency for FIX_EARLYCON_MEM
> - Call early_fixmap_init conditionally, only if FIX_EARLYCON_MEM is set
<snip>

Submitted to the patch tracker as 8415/1.

--
Stefan
