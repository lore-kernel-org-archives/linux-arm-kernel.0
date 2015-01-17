From: jcm@redhat.com (Jon Masters)
Date: Sat, 17 Jan 2015 11:36:20 -0500
Subject: [PATCHv4] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <20150117121247.GL3827@bivouac.eciton.net>
References: <1412437603-3394-1-git-send-email-yi.li@linaro.org>
 <54B9F9D2.6000104@redhat.com> <20150117121247.GL3827@bivouac.eciton.net>
Message-ID: <54BA8F84.1010507@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2015 07:12 AM, Leif Lindholm wrote:

>> So. If I wanted this available prior to early_initcall time, would it be
>> reasonable to follow e.g. x86 and move this early in the boot? I'm not
>> necessarily going to ask to upstream such a change (since I expect to be
>> able to solve the underlying problem I am looking to address in a
>> different fashion soon), but first want to know if it would be
>> reasonable to ask to do that anyway.
> 
> My suggestion would be to not try to over-engineer a patch not going
> upstream. Move the call before smp_prepare_cpus() in init/main.c.
> 
> Or, if you can be fairly certain your SMBIOS table is covered by the
> linear mapping, move the call to setup_arch().

Note: actually dmi_early_remap is defined sufficiently on AArch64 today
to do the right thing creating a mapping or reusing the linear one.

Jon.
