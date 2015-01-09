From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Jan 2015 16:46:08 +0000
Subject: [PATCH] arm: Remove early stack deallocation from
 restore_user_regs
In-Reply-To: <1420470758-5874-1-git-send-email-daniel.thompson@linaro.org>
References: <1418382718-16323-1-git-send-email-daniel.thompson@linaro.org>
 <1420470758-5874-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20150109164608.GV12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 05, 2015 at 03:12:38PM +0000, Daniel Thompson wrote:
> Currently restore_user_regs deallocates the SVC stack early in
> its execution and relies on no exception being taken between
> the deallocation and the registers being restored. The introduction
> of a default FIQ handler that also uses the SVC stack breaks this
> assumption and can result in corrupted register state.
> 
> This patch works around the problem by removing the early
> stack deallocation and using r2 as a temporary instead. I have
> not found a way to do this without introducing an extra mov
> instruction to the macro.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---

Please put it in the patch system, thanks.  I think we should queue
this one for stable too, as I think we need this for v3.18
(as a result of c0e7f7ee717e2b4c5791e7422424c96b5008c39e,
ARM: 8150/3: fiq: Replace default FIQ handler)?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
