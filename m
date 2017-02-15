From: james.morse@arm.com (James Morse)
Date: Wed, 15 Feb 2017 12:12:35 +0000
Subject: [PATCH v32 07/13] arm64: hibernate: preserve kdump image around
 hibernation
In-Reply-To: <20170207080904.5974-5-takahiro.akashi@linaro.org>
References: <20170207080601.5816-1-takahiro.akashi@linaro.org>
 <20170207080904.5974-5-takahiro.akashi@linaro.org>
Message-ID: <58A445B3.4080608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 07/02/17 08:08, AKASHI Takahiro wrote:
> Since arch_kexec_protect_crashkres() removes a mapping for crash dump
> kernel memory, the loaded contents won't be preserved around hibernation.
> 
> In this patch, arch_kexec_(un)protect_crashkres() are additionally called
> before/after hibernation so that the relevant region will be mapped again
> and restored just as the other memory regions are.

Reviewed-by: James Morse <james.morse@arm.com>

A quick test of this took longer than expected (writing to a slow usb device), I
suspect it is save/restoring the whole crash region (which I don't think is a
problem). If someone turns out to use this combination of features I will look
at improving this, (almost certainly requires core-code changes).


Thanks,

James
