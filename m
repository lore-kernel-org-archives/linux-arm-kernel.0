From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Mar 2015 18:09:58 +0000
Subject: [PATCH] arm64/crypto: issue aese/aesmc instructions in pairs
In-Reply-To: <1426615513-28587-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1426615513-28587-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150317180957.GC8399@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 06:05:13PM +0000, Ard Biesheuvel wrote:
> This changes the AES core transform implementations to issue aese/aesmc
> (and aesd/aesimc) in pairs. This enables a micro-architectural optimization
> in recent Cortex-A5x cores that improves performance by 50-90%.
> 
> Measured performance in cycles per byte (Cortex-A57):
> 
>                 CBC enc         CBC dec         CTR
>   before        3.64            1.34            1.32
>   after         1.95            0.85            0.93
> 
> Note that this results in a ~5% performance decrease for older cores.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> Will,
> 
> This is the optimization you yourself mentioned to me about a year ago
> (or even longer perhaps?) Anyway, we have now been able to confirm it
> on a sample 'in the wild', (i.e., a Galaxy S6 phone)

I barely remember one day to the next, but hey! I'll queue this for 4.1.

Will
