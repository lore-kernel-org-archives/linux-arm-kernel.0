From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 14 Mar 2014 15:57:44 -0700
Subject: [PATCH v4 02/10] ARM/ARM64: KVM: Add base for PSCI v0.2 emulation
In-Reply-To: <001201cf245e$37a37a20$a6ea6e60$@samsung.com>
References: <1391686302-19451-1-git-send-email-anup.patel@linaro.org>
 <1391686302-19451-3-git-send-email-anup.patel@linaro.org>
 <003501cf23de$a4a878d0$edf96a70$@samsung.com>
 <CAAhSdy3Y3N7pSr3Y0rB7p340sX_kGPFT7mmBa2Rvf2pdSJYAfA@mail.gmail.com>
 <003a01cf23e4$07f07af0$17d170d0$@samsung.com>
 <CAAhSdy2p5rfBR59sGbs_mZvh3WmnPAJA2=OwEmdN2xrxp7R2Ug@mail.gmail.com>
 <001201cf245e$37a37a20$a6ea6e60$@samsung.com>
Message-ID: <20140314225744.GH28661@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 08, 2014 at 08:42:09AM +0900, Jungseok Lee wrote:

[...]

> 
> No, I am not.
> My original intention is to clarify the interface between KVM and VM if
> DVFS scheme is applied to VM. Currently, PSCI v0.2 does not define it.
> Thus, I wonder why this interface is not covered.
> 

Why would you run DVFS in a VM?  When the VCPUs in a VM are idle they
consume zero resources.  The host would be doing the DVFS for thermal
regulation and such.

The only thing I can see being relevant is having some mechanism of
informing the host of characteristics of the guest so the host can be
more educated when enforcing power policy, but that requires a
theoretical discussion and rationale first.

-Christoffer
