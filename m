From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Nov 2013 10:03:37 -0700
Subject: [PATCH] ARM: move firmware_ops to drivers/firmware
In-Reply-To: <20131118115842.GE4050@arm.com>
References: <1384678169-28228-1-git-send-email-acourbot@nvidia.com>
 <CAHkRjk5LBOFx3ir49RgEsaFwvp5UCpTjYFWto+URXebAsOP0RA@mail.gmail.com>
 <52898417.80601@nvidia.com> <20131118115842.GE4050@arm.com>
Message-ID: <528A4869.2020701@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2013 04:58 AM, Catalin Marinas wrote:
...
> Of course, trusted foundations interface could be plugged into cpu_ops
> on arm64 but I will NAK it on the grounds of not using the PSCI API, nor
> the SMC calling convention (and it's easy to fix when porting to ARMv8).
> If a supported standard API is used, then there is no need for
> additional code in the kernel.

What happens when someone takes an existing working secure-mode SW stack
and simply re-uses it on some new ARMv8 SoC. Are you going to force
people working on upstream to re-write the secure mode firmware in
shipped hardware before allowing upstream kernel support?
