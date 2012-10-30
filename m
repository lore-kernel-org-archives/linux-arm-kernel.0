From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 30 Oct 2012 10:53:12 -0600
Subject: [PATCH 1/2] arm: bcm2835: move to the multiplatform support
In-Reply-To: <20121030092046.7d20407b@skate>
References: <1351419853-25146-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <508F3BFF.6010305@wwwdotorg.org> <20121030092046.7d20407b@skate>
Message-ID: <509005F8.5030006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2012 02:20 AM, Thomas Petazzoni wrote:
> Stephen,
> 
> Thanks for taking the time to look at this patch.
> 
> On Mon, 29 Oct 2012 20:31:27 -0600, Stephen Warren wrote:
> 
>> Since CONFIG_VFP is enabled in bcm2835_defconfig (or in general, could
>> be enabled in anyone's .config), I guess that means I can't apply the
>> patch yet, because the VFP fix you mention above doesn't seem to have
>> been applied anywhere, so applying it would cause bcm2835_defconfig to
>> be unbootable. To apply this, I'd need to merge in a branch containing
>> the VFP fix first.
> 
> I'm pretty sure the VFP fix will land somewhere at some point, we can
> wait this moment to merge this multiplatform bcm2835 support patch.
> 
>> What branch is this patch series based on? Neither "git am" not "git am
>> -3" will apply the series; apparently my repo doesn't have the blobs to
>> perform the 3-way merge -3 invokes even though I have a remote for
>> linux-next which should pick up most blob sources.
> 
> This is my fault, sorry. I based this patch on a branch that contains
> the VFP fix + the irqchip changes I've been proposing. I can resend a
> new version based on 3.7-rc3, or arm-soc/for-next, at your preference.

(Once the dependencies are in arm-soc somewhere...) It'd be best to base
it on v3.7-rcN, either with/without the VFP and debug_ll_io_init()
patches merged (since I'll apply the patch only on top of those two
patches anyway.

Thanks.
