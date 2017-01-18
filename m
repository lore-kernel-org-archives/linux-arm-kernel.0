From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 18 Jan 2017 15:51:21 -0800
Subject: [PATCH 2/5] ARM: Makefile: Generalize qcom platform text offset
In-Reply-To: <20170118233115.GV27312@n2100.armlinux.org.uk>
References: <20170118232726.22876-1-sboyd@codeaurora.org>
 <20170118232726.22876-3-sboyd@codeaurora.org>
 <20170118233115.GV27312@n2100.armlinux.org.uk>
Message-ID: <20170118235121.GW17126@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18, Russell King - ARM Linux wrote:
> On Wed, Jan 18, 2017 at 03:27:23PM -0800, Stephen Boyd wrote:
> > Some qcom platforms need a specific text offset because the first
> > 2MB of memory is reserved for shared memory. Let's just always
> > shift the text segment up by 2MB when ARCH_QCOM is selected so
> > that we don't have to specify the specific platforms that exhibit
> > this problem in Kconfig.
> 
> I was really hoping that this sillyness would stop, but I guess
> expecting it to stop is asking too much...
> 
> Is there really no other option?
> 

The only other option is to make up some qcom specific config
like I_HAVE_A_QCOM_SOC_THAT_NEEDS_2MB_OFFSET that can be selected
when the configurator (not a word) knows that they are using that
SoC.

Overall, this practice has stopped inside the company over 3
years ago and has not continued as far as I know. This patch is
just taking the easy way out and forcing ARCH_QCOM to always do
the shift.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
