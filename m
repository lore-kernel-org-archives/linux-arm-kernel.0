From: mmarek@suse.cz (Michal Marek)
Date: Sat, 14 Jan 2012 23:51:29 +0100
Subject: [PATCH 2/2] Kbuild: Use dtc's -d (dependency) option
In-Reply-To: <1326310587.2535.291.camel@deneb.redhat.com>
References: <1326134295-15547-1-git-send-email-swarren@nvidia.com>
 <1326134295-15547-2-git-send-email-swarren@nvidia.com>
 <1326310587.2535.291.camel@deneb.redhat.com>
Message-ID: <4F1206F1.5090405@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.1.2012 20:36, Mark Salter wrote:
> On Mon, 2012-01-09 at 11:38 -0700, Stephen Warren wrote:
>> This hooks dtc into Kbuild's dependency system.
>>
>> Thus, for example, "make dtbs" will rebuild tegra-harmony.dtb if only
>> tegra20.dtsi has changed yet tegra-harmony.dts has not. The previous
>> lack of this feature recently caused me to have very confusing "git
>> bisect" results.
>>
>> For ARM, it's obvious what to add to $(targets). I'm not familiar enough
>> with other architectures to know what to add there. Powerpc appears to
>> already add various .dtb files into $(targets), but the other archs may
>> need something added to $(targets) to work.
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>>
> 
> Acked-by: Mark Salter <msalter@redhat.com>
> 
> For the arch/c6x bit.

As the C6X port has been merged in this merge window, I can't easily
apply this patch to my kbuild branch and at the same time please Linus
by basing the pull request on a tagged release. So I'm going to drop the
arch/c6x part to keep the kbuild branch "pretty" and let either Mark or
Stephen send the patch to Linus directly, once he has merged the kbuild
branch. Would that work?

Thanks,
Michal
