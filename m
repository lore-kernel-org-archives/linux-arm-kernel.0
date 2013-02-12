From: rogerq@ti.com (Roger Quadros)
Date: Tue, 12 Feb 2013 16:46:51 +0200
Subject: linux-next: manual merge of the arm-soc tree with the mfd tree
In-Reply-To: <20130211185221.GR4801@atomide.com>
References: <20130211170616.73fd9fd30bb10c27a698ad4d@canb.auug.org.au>
 <20130211185221.GR4801@atomide.com>
Message-ID: <511A55DB.7040808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2013 08:52 PM, Tony Lindgren wrote:
> * Stephen Rothwell <sfr@canb.auug.org.au> [130210 22:11]:
>> Hi all,
>>
>> Today's linux-next merge of the arm-soc tree got a conflict in
>> arch/arm/mach-omap2/usb-host.c between commit 8a89e93237e1 ("mfd:
>> omap-usb-host: Consolidate OMAP USB-HS platform data") from the mfd tree
>> and commit c1d1cd597fc7 ("ARM: OMAP2+: omap_device: remove obsolete
>> pm_lats and early_device code") from the arm-soc tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary (no action
>> is required).
> 
> Thanks again.
> 
> Samuel, up to you, but I suggest you just drop these patches for
> now if still possible unless other patches are based on these.
> 

Samuel, please feel free to drop the 20 patches you pulled from me recently.

I have another set patches that would depend on them and I think it is better if
both sets go through usb and arm-soc trees. This would avoid some confusion.

Once you confirm I can add your Acked-by's to them and send fresh pull requests
to Tony & Greg. Thanks.

> All OMAP USB people, doing these things should be pretty trivial,
> just follow these steps:
> 
> 1. Do all the platform data and header changes first so we can
>    put them into a shared minimal topic branch either in the
>    USB tree or arm-soc tree
> 
> 2. Modify the USB driver(s) based on #1 and have them merged into
>    the USB tree
> 
> 3. Add new arch/arm related pdata and .dts entries based on #1
>    so we can merge it via arm-soc tree
> 
> 4. Remove all the old crap later on to avoid extra dependencies
>    between these branches
> 
Thanks Tony.

cheers,
-roger
