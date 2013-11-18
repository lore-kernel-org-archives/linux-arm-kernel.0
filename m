From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Nov 2013 10:18:33 -0700
Subject: [PATCH] ARM: move firmware_ops to drivers/firmware
In-Reply-To: <20131118171023.GH16735@n2100.arm.linux.org.uk>
References: <1384678169-28228-1-git-send-email-acourbot@nvidia.com>
 <CAHkRjk5LBOFx3ir49RgEsaFwvp5UCpTjYFWto+URXebAsOP0RA@mail.gmail.com>
 <52898417.80601@nvidia.com> <20131118115842.GE4050@arm.com>
 <528A4869.2020701@wwwdotorg.org>
 <20131118171023.GH16735@n2100.arm.linux.org.uk>
Message-ID: <528A4BE9.9070501@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2013 10:10 AM, Russell King - ARM Linux wrote:
> On Mon, Nov 18, 2013 at 10:03:37AM -0700, Stephen Warren wrote:
>> On 11/18/2013 04:58 AM, Catalin Marinas wrote:
>> ...
>>> Of course, trusted foundations interface could be plugged into cpu_ops
>>> on arm64 but I will NAK it on the grounds of not using the PSCI API, nor
>>> the SMC calling convention (and it's easy to fix when porting to ARMv8).
>>> If a supported standard API is used, then there is no need for
>>> additional code in the kernel.
>>
>> What happens when someone takes an existing working secure-mode SW stack
>> and simply re-uses it on some new ARMv8 SoC. Are you going to force
>> people working on upstream to re-write the secure mode firmware in
>> shipped hardware before allowing upstream kernel support?
> 
> I'll tell you what will happen.  They'll say "screw mainline, we're doing
> our own thing".  Vendors have been doing that for years, this will be no
> different and require no additional effort from them.

Yes, that's my point.

However, what does that mean for those people within the company trying
to move the SW stack towards mainline? If the answer from upstream is:
"no, you can't support the shipping HW in mainline", rather than a
practical approach that recognizes that the HW/SW/firmware really does
exist and might be useful to support in mainline, then that just makes
the life of people trying to push for mainline that much harder.
